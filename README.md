# 🏦 Bank Customer Segmentation & Transaction Analysis

### 📋 Project Objective
The goal of this project was to analyze bank transactions to perform customer segmentation and analyze transaction volume trends. The raw data contained severe errors and legacy queries caused server bottlenecks, requiring a robust data cleansing pipeline before accurate analysis could be performed.

### 🗂️ Data Source
* **Dataset:** [Bank Customer Segmentation Dataset (Kaggle)](https://www.kaggle.com/datasets/shivamb/bank-customer-segmentation)

### 🛠️ Tools & Technologies
* **Data Warehouse / SQL Engine:** Google BigQuery
* **Data Visualization:** Microsoft Power BI

### 📊 Key Business Insights
* **The Gender Spending Gap:** While male customers dominate the overall transaction volume (72%), female customers (28%) spend significantly more per transaction. The average transaction value for women is 1,599.83 INR, compared to only 1,397.70 INR for men.
* **Top Performing Hub:** Mumbai is the undisputed leading market for the bank. It has the highest volume of transactions and generates the highest total revenue, bringing in over 162 Million INR.
* **Data Quality Crisis:** The raw demographic data contained massive errors, such as 57,000 customers listed with a birth year of 1800. Filtering these anomalies out left a highly reliable dataset of 987,831 valid transactions for accurate analysis.

### 💡 Strategic Recommendations
* **Targeted Financial Products:** Design and launch a premium credit card with higher fees and better rewards specifically targeted at female customers, as the data proves they have a higher spending power per transaction.
* **Strategic Expansion:** Focus marketing budgets, new ATM installations, and branch expansion campaigns primarily in Mumbai to maximize ROI, while tailoring ads for the highly active 26-35 age group.
