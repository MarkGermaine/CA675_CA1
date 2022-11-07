toys = LOAD 's3://ca675-assignment-1/input/toys/' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') AS (index:int,id:chararray,reviewerID:chararray,asin:int,reviewerName:chararray,helpful:chararray,reviewText:chararray,overall:int,summary:chararray,unixReviewTime:int,reviewTime:chararray,category:chararray,class:int);
sports = LOAD 's3://ca675-assignment-1/input/sports/' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'NO_MULTILINE', 'NOCHANGE', 'SKIP_INPUT_HEADER') AS (index:int,id:chararray,reviewerID:chararray,asin:int,reviewerName:chararray,helpful:chararray,reviewText:chararray,overall:int,summary:chararray,unixReviewTime:int,reviewTime:chararray,category:chararray,class:int);
reviews = UNION toys, sports;
f = FILTER reviews BY NOT (id IS NULL OR reviewerID IS NULL);
clean_review = FOREACH f GENERATE reviewerID, summary, overall, reviewText, class;
spam = FILTER clean_review BY class == 1;
ham = FILTER clean_review BY class == 0;
STORE spam INTO 's3://ca675-assignment-1/output/pig/spam' USING PigStorage(',');
STORE ham INTO 's3://ca675-assignment-1/output/pig/ham' USING PigStorage(',');
