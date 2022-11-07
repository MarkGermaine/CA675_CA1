DEFINE tokenize_docs `ruby tokenize_documents.rb --id_field=0 --text_field=1 --map` SHIP('tokenize_documents.rb');

raw_documents = LOAD 's3://ca675-assignment-1/output/hive/ham/tfidf/' AS (doc_id:chararray, text:chararray);
tokenized     = STREAM raw_documents THROUGH tokenize_docs AS (doc_id:chararray, token:chararray);
doc_tokens       = GROUP tokenized BY (doc_id, token);
doc_token_counts = FOREACH doc_tokens GENERATE FLATTEN(group) AS (doc_id, token), COUNT(tokenized) AS num_doc_tok_usages;
doc_usage_bag    = GROUP doc_token_counts BY doc_id;

doc_usage_bag_fg = FOREACH doc_usage_bag GENERATE group AS doc_id, 
FLATTEN(doc_token_counts.(token, num_doc_tok_usages)) AS (token, num_doc_tok_usages), 
SUM(doc_token_counts.num_doc_tok_usages) AS doc_size;

term_freqs = FOREACH doc_usage_bag_fg GENERATE doc_id AS doc_id,
token AS token,
((double)num_doc_tok_usages / (double)doc_size) AS term_freq;
;

term_usage_bag  = GROUP term_freqs BY token;

token_usages    = FOREACH term_usage_bag GENERATE
FLATTEN(term_freqs) AS (doc_id, token, term_freq),
COUNT(term_freqs) AS num_docs_with_token;

tfidf_all = FOREACH token_usages {
              idf    = LOG((double)$NDOCS/(double)num_docs_with_token);
              tf_idf = (double)term_freq*idf;
                GENERATE
                  doc_id AS doc_id,
                  token  AS token,
                  tf_idf AS tf_idf
                ;
             };