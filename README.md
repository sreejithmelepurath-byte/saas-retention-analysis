SaaS Cohort Retention and "Leaky Bucket" Analysis
View the full PDF Presentation and Heatmap

Executive Summary
This project analyzes a dataset of 10,000 SaaS users to identify critical churn points in the customer lifecycle. By transforming raw transactional logs into a 12-month cohort retention matrix, I was able to pinpoint exactly where user drop-off accelerates and calculate the financial impact on Monthly Recurring Revenue (MRR).

Key Findings:

The Month-3 Cliff: Across all cohorts, average retention falls sharply from 83.4% at Month 2 to 69.5% at Month 3.

Financial Impact: Extrapolating this Month-3 churn rate for Basic-tier users reveals an estimated $15,000+ in MRR leakage per monthly cohort, which translates to an annualized exposure of over $180,000.

Strategic Recommendation: Implement an automated, targeted intervention sequence starting at Day 75. Offering a 15% discount for an annual upgrade could proactively bypass the Month-3 cancellation window.

Methodology and Tools
Data Engineering (Python): Used and (applying Gamma statistical distributions) to generate 10,000 realistic subscription logs that model real-world user drop-off behaviors.pandasNumPy

Data Transformation (SQL): Leveraged PostgreSQL—including CTEs, grouped aggregations, date-truncation, and period-offset logic—to convert raw event logs into a structured User Retention Matrix.

Repository Files
generate_data.py: Python script used to simulate the raw transactional data.

transform_cohorts.sql: SQL query used to build the cohort retention matrix and calculate the retained and lost MRR.

SaaS_Cohort_Retention_Analysis.pdf: Final visual report and business recommendations.
