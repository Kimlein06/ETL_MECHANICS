# ETL Pipeline Demonstration
## Tools
- Python
- SQL with MySQL
- R
- Shell

In this demonstration, I present an end-to-end ETL pipeline built using multiple tools to highlight the mechanics of data processing.

**Extraction (Python)**: I use Python to connect to the OpenFoodFacts API, extract product data, and store it in a structured format (CSV).
#### Note
You can run *pip install -r requirements.txt* to install all depedencies.

**Transformation (SQL/MySQL)**: The raw data is loaded into a MySQL database where I perform cleaning and transformations, including filtering invalid records and applying aggregations. A dummy transactions table is also included to simulate sales activity, enabling meaningful summaries.
#### Note
- For SQL you might need to enable local file loading
*SET GLOBAL local_infile = 1;*
- Fill in the absolute path to the file created by the python file


**Loading & Analysis (R)**: The transformed data is then staged for analysis and visualization in R, where I generate charts to reveal insights such as sales by category and nutrition score.
#### Note
- You can include the packages used in R together in one file **load.r** but i created a separate file **packages.r** where I included them for easier identification.
- Fill in the username, **password**, **database name**, **host** and **port** of your database server. In this demonstration I used MySQL

**Automation**: To streamline the workflow, I included a shell script that orchestrates the entire process — from extraction to transformation to visualization — ensuring a repeatable and automated pipeline.
#### Note
- If all relevant fields are filled then you can simply run a shell script to automatically execute the ETL pipline
*sh automate.sh*

This demonstration shows how **Python**, **SQL**, and **R** can work together in an integrated pipeline, mirroring real-world ETL processes used in data warehousing and analytics.

