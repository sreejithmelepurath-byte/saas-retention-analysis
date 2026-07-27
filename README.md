# saas-retention-analysis
Analyzing SaaS customer churn and MRR using Python and SQL
# 🪣 SaaS Cohort Retention & "Leaky Bucket" Analysis

**[📄 Click here to view the full PDF Presentation & Heatmap](SaaS_Cohort_Retention_Analysis.pdf)**

## 📌 Executive Summary
This project analyzes a simulated dataset of 10,000 SaaS software users to identify critical churn points in the customer lifecycle. By engineering raw transactional logs into a 12-month cohort retention matrix, I isolated the exact point where churn accelerates and translated that behavioral signal into its financial impact on Monthly Recurring Revenue (MRR).

**Key Findings:**
* **The Month-3 Cliff:** Across all cohorts, average retention falls sharply from 83.4% at Month 2 to just 69.5% at Month 3.
* **Financial Impact:** Extrapolating the Month-3 churn rate of Basic-tier users reveals an estimated **$15,000+ in MRR leakage** per monthly cohort (an annualized exposure of $180,000+).
* **Strategic Recommendation:** Implement an automated, targeted intervention sequence beginning at Day 75 (a 15% discount incentive for an annual upgrade) to proactively bypass the Month-3 cancellation window.

## 🛠️ Methodology & Tools
* **Data Engineering (Python):** Utilized `pandas` and `NumPy` (specifically skewed Gamma statistical distributions) to generate 10,000 realistic subscription logs and model real-world user drop-off behaviors.
* **Data Transformation (SQL):** Leveraged PostgreSQL (CTEs, grouped aggregations, date-truncation, and period-offset logic) to convert raw event-level logs into a structured User Retention Matrix.

## 📂 Repository Files
* `generate_data.py`: The Python script used to simulate the raw transactional data.
* `transform_cohorts.sql`: The SQL query used to build the cohort retention matrix and calculate MRR lost/retained.
* `SaaS_Cohort_Retention_Analysis.pdf`: The final visual report and business recommendation.
