#  ETL pipeline

echo "Starting ETL pipeline...."

# Extract
echo "Extracting using Python script"
python3 extract.py

# Transfom and Load
echo "Transforming using SQL script"
mysql -u root -p'kimlein@06' etl_db < transform.sql

# Visualize
echo "Visualizing using R script"
Rscript load.r

echo "ETL pipeline completed."