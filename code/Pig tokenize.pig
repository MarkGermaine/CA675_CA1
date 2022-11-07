spam = LOAD 's3://ca675-assignment-1/output/pig/spam/'USING org.apache.pig.piggybank.storage.CSVExcelStorage('\t', 'NO_MULTILINE', 'NOCHANGE') AS (reviewerID:chararray, summary:chararray, overall:int, reviewText:chararray, class:int);
ham = LOAD 's3://ca675-assignment-1/output/pig/ham/' USING org.apache.pig.piggybank.storage.CSVExcelStorage('\t', 'NO_MULTILINE', 'NOCHANGE') AS (reviewerID:chararray, summary:chararray, overall:int, reviewText:chararray, class:int);

post_ham = FOREACH ham GENERATE reviewerID, overall, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE((REPLACE(summary,'[\r\n]+','')),'<[^>]*>' , ' '),'[^a-zA-Z\\s\']+',' '),'(?=\\S*[\'])([a-zA-Z\'-]+)',''),'(?<![\\w\\-])\\w(?![\\w\\-])',''),'[ ]{2,}',' ') AS summary;
post_spam = FOREACH spam GENERATE reviewerID, overall, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE((REPLACE(summary,'[\r\n]+','')),'<[^>]*>' , ' '),'[^a-zA-Z\\s\']+',' '),'(?=\\S*[\'])([a-zA-Z\'-]+)',''),'(?<![\\w\\-])\\w(?![\\w\\-])',''),'[ ]{2,}',' ') AS summary;

filter_ham = FILTER post_ham BY (summary is not null);
filter_spam = FILTER post_spam BY (summary is not null);

token_ham = foreach filter_ham generate reviewerID, TOKENIZE(summary);
token_spam = foreach filter_spam generate reviewerID, TOKENIZE(summary);

limit_ham = LIMIT token_ham 3;
dump limit_ham;

limit_spam = LIMIT token_spam 3;
dump limit_spam;