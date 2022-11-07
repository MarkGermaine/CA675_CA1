DROP TABLE IF EXISTS spam;

CREATE EXTERNAL TABLE spam (reviewerID String,reviewText String,overall int,summary String,class int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION "s3://ca675-assignment-1/output/pig/spam";

SELECT reviewerid,count(*) FROM spam GROUP BY reviewerid ORDER BY count(*) DESC LIMIT 10;


INSERT OVERWRITE DIRECTORY "s3://ca675-assignment-1/output/hive/spam/"
SELECT reviewerid,count(*) FROM spam GROUP BY reviewerid ORDER BY count(*) DESC LIMIT 10;
