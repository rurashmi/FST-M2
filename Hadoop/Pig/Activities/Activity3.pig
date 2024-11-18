-- Load the CSV file
salesInput = LOAD 'hdfs:///user/rupam/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesInput BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
--Remove the old output
rmf hdfs:///user/rupam/PigOutput2;
-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/rupam/PigOutput2' using PigStorage('\t');
