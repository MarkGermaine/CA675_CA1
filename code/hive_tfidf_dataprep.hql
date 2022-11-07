DROP TABLE IF EXISTS ham_10;

CREATE EXTERNAL TABLE ham_10 (reviewerID String,reviewText String,overall int,summary String,class int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION "s3://ca675-assignment-1/output/pig/ham/";

select reviewerid, summary from ham_10 LIMIT 10;

insert overwrite directory "s3://ca675-assignment-1/output/hive/ham/tfidf/"
select reviewerid, summary from ham_10;

#Tab separated ^^^

DROP TABLE IF EXISTS spam_10;

CREATE EXTERNAL TABLE spam_10 (reviewerID String,reviewText String,overall int,summary String,class int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION "s3://ca675-assignment-1/output/hive/spam/";

select reviewerid, summary from spam_10 LIMIT 10;


insert overwrite directory "s3://ca675-assignment-1/output/hive/spam/tfidf/"
select reviewerid, summary from spam_10;
