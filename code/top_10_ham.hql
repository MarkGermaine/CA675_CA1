DROP TABLE IF EXISTS ham;

CREATE EXTERNAL TABLE ham (reviewerID String,reviewText String,overall int,summary String,class int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION "s3://ca675-assignment-1/output/pig/ham";

SELECT reviewerid,count(*) FROM ham GROUP BY reviewerid ORDER BY count(*) DESC LIMIT 10;


INSERT OVERWRITE DIRECTORY "s3://ca675-assignment-1/output/hive/ham/"
SELECT reviewerid,count(*) FROM ham GROUP BY reviewerid ORDER BY count(*) DESC LIMIT 10;
