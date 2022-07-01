 ## Project 2: Loading Online Event Hits using Sqoop to Hive via Shell Script (SCD2)

In this project Data is sent by the client everyday in CSV format. So load all the data in MySQL everyday and then export it to HDFS. From there load the Data to hive and do the partioning on Year and Month and implement SCD Type-2 Logic and then load the data for Data reconcilation so that no loss of data takes place at any day.

        

        

          



        

        

          

# Implementing_scd_in_hive

        

        

          

The project is to get the file and load the data to RDBMS initially and update the table whenever the changes happend in the data.

        

        

          

Steps for Implementing:

        

        

          

1. Getting the source files and dump in the Edge Node.

        

        

          

2. Load the data from MySQL to HDFS.

        

        

          

3. Import the data to hive managed table from HDFS.

        

        

          

4. Partition and import the data from the managed table to External table and implement the scd logic from the day 2.

        

        

          

5. Create an intermediate table to perform data reconciliation.

        

        

          

6. Export the filtered data again to the MySQL table.This is the project which is based on the concept of Hadoop, Sqoop, Hive, Sql and Shell Scripting. In this project, SCD-2 logic is implemented using shell scripting, hive and Sqoop.

        

