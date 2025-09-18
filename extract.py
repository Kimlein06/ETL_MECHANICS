import requests
import pandas as pd

# calling API
url = "https://world.openfoodfacts.org/category/beverages.json"

# fetch data
response = requests.get(url)
data = response.json()

# product info
product = data['products']

records = []

for item in product:
    records.append({
        "product_name": item.get("product_name", ""),
        "brands": item.get("brands", ""),
        "categories": item.get("categories", ""),
        "nutrition_score": item.get("nutriscore_grade", ""),
    })

# create dataframe
df = pd.DataFrame(records)

# create csv
df.to_csv("raw_products.csv", index=False)
print(df.head())