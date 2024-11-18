-- Load the CSV file
salesInput = LOAD '/root/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesInput BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
--Remove the old output
rmf /root/PigOutput2;
-- Save result in HDFS folder
STORE CountByCountry INTO '/root/PigOutput2';
