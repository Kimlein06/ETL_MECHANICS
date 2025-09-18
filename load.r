library(DBI)
library(RMySQL)
library(ggplot2)
# Connect to the MySQL database
 con <- dbConnect(
        RMySQL::MySQL(),
        username = "", # your username here
        password = "", # your password here
        dbname = "", # your database name here
        host = "", # your host here
        port = 3306) # your port here commonly 3306

# load data
sales = dbGetQuery(con, "SELECT categories, nutrition_score, total_sold 
                        FROM sales_summary ORDER BY total_sold DESC;")

# Plot the data
sales$primary_category <- sapply(strsplit(sales$categories, ","), function(x) trimws(x[1]))

ggplot(sales, aes(x = reorder(primary_category, total_sold), y = total_sold)) +
    geom_col() +
    coord_flip() +
    labs(title = "Total Products Sold by Primary Category",
         x = "Primary Category",
         y = "Total Products Sold") +
    theme_minimal()

# save the plot 
ggsave("sales_by_category.png")
        

# Disconnect from the database
dbDisconnect(con)