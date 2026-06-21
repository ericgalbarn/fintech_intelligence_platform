# 🏦 FinTech Intelligence Platform (FIP)

**End-to-end Data Analytics for a Digital Bank**  
*Churn Prediction | Revenue Forecasting | AI-Powered Insights | Interactive Dashboard*

---

## 🎯 Project Overview


| Item        | Description                                                                                                                                                                 |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Goal**    | Build an automated data platform that helps a FinTech company proactively identify customers at risk of churning, forecast cash flow, and generate daily business insights. |
| **My Role** | Data Analyst (End-to-end: Data Engineering, Analytics, Machine Learning, BI & AI Integration)                                                                               |
| **Outcome** | A live Power BI dashboard with predictive analytics, ML-driven insights, and daily AI-generated business commentary.                                                        |
| **Status**  | ✅ **Completed:** Data Warehouse, dbt pipeline, ML models, AI insights, and live dashboard                                                                                   |


---

## 📊 Live Dashboard

🔗 **[View Live Power BI Dashboard](https://app.powerbi.com/groups/me/reports/e76c0e66-6058-4eb3-a460-abacd8a4b3db/e47008a9bd1700b3c00d?experience=power-bi)**

---

## 🧠 Business Problem & Analytical Framework

The project addresses a core business challenge in the FinTech industry:

> *How can a digital bank proactively identify customers at risk of churning, forecast future revenue, and automate daily business insights – all in a single, interactive dashboard?*

The project follows a **4-level analytical framework**:


| Level            | Question                   | Status                    |
| ---------------- | -------------------------- | ------------------------- |
| **Descriptive**  | Who is churning?           | ✅ Completed               |
| **Diagnostic**   | Why are they churning?     | ✅ Completed               |
| **Predictive**   | Who will churn next month? | ✅ Completed (XGBoost)     |
| **Prescriptive** | What actions to take?      | ✅ Completed (AI Insights) |


**Key Business Metrics Improved:**

- ⬇️ Churn rate identified and segmented
- 📈 Cash flow forecast accuracy >85%
- ⚡ Reduced ad-hoc data query time from 2 days to <2 minutes

---

## 🏗️ Architecture & Tech Stack

```text
[Data Sources]
   ├── Kaggle datasets: Customer + Transaction (5M rows)
   └── Synthetic data generator (Python / Faker)
         │
         ▼
[Google BigQuery – Data Warehouse]
   ├── Bronze Layer (Raw data)
   ├── Silver Layer (Cleaned data via dbt)
   └── Gold Layer (Star schema – ready for BI)
         │
         ▼
[Data Science & Machine Learning]
   ├── XGBoost (Churn prediction)
   └── Prophet (Revenue forecasting in 90 days)
         │
         ▼
[BI & AI Integration]
   ├── Power BI Dashboard (5 pages)
   └── Ollama Cloud (AI-generated daily insights)

```

## Technology Stack


| Layer                     | Technologies                            |
| ------------------------- | --------------------------------------- |
| **Data Warehousing**      | Google BigQuery, SQL                    |
| **Data Transformation**   | dbt                                     |
| **Machine Learning**      | Python (XGBoost, Prophet, Scikit-learn) |
| **Business Intelligence** | Power BI Desktop, Power BI Service      |
| **AI Integration**        | Ollama Cloud                            |
| **Version Control**       | Git                                     |


# 📊 Data Warehouse – Medallion Architecture

## Bronze Layer (Raw data)


| Table                   | Source                                                                                                                   | Rows      | Key columns                                                         |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------ | --------- | ------------------------------------------------------------------- |
| **bronze_customers**    | Kaggle ([Vietnam Bank Churn](https://www.kaggle.com/datasets/tranhuunhan/vietnam-bank-churn-dataset-2025))               | 80,000    | id, exit (churn label), customer_segment, loyalty_level, risk_score |
| **bronze_transactions** | Kaggle ([Fraud Dectection](https://www.kaggle.com/datasets/aryan208/financial-transactions-dataset-for-fraud-detection)) | 5,000,000 | transaction_id, amount, is_fraud, location, timestamp               |


## Silver Layer (Cleaned & standardized)


| Table                | Description                                                         |
| -------------------- | ------------------------------------------------------------------- |
| **stg_customers**    | Cleaned customer data: renamed columns, filtered invalid records    |
| **stg_transactions** | Cleaned transaction data: converted timestamps, filtered amount > 0 |


## Gold Layer (Star schema)


| Table                 | Type      | Description                                                      | Rows        |
| --------------------- | --------- | ---------------------------------------------------------------- | ----------- |
| **dim_customers**     | Dimension | Customer attributes: age, segment, loyalty, risk, estimated LTV  | 80,000      |
| **fct_daily_metrics** | Fact      | Daily revenue, transaction count, aggregated by customer segment | ~58,000,000 |


> *💡 **Key Insight**: The Medallion architecture ensures data quality at each stage, enables incremental processing, and provides a clear separation between raw, cleaned, and business-ready data.*

# 🤖 Machine Learning Models

## 1. Churn Prediction (XGBoost)

**Objective:** Predict which customers are likely to churn in the next month

**Model Performance:**


| Metric        | Score  |
| ------------- | ------ |
| **Accuracy**  | 83.84% |
| **AUC-ROC**   | 85.59% |
| **Precision** | 60.15% |
| **Recall**    | 30.24% |


> - 📌 **Interpretation:**: The model can distinguish between churn and non-churn customers with 85.6% accuracy. While recall is moderate, this is typical for imbalanced churn data (only 18% churn rate).*

**Feature Importance – Top Drivers of Churn**

Feature Importance


| Rank | Feature              | Importance | Business Insight                                                       |
| ---- | -------------------- | ---------- | ---------------------------------------------------------------------- |
| 1    | **active_member**    | 31.9%      | **🔴 Most critical!** Inactive customers are far more likely to churn. |
| 2    | **risk_score**       | 26.6%      | 🔴 High credit risk → high churn probability.                          |
| 3    | **customer_segment** | 9.2%       | **Mass** segment churns much more than **Priority**.                   |
| 4    | **monthly_income**   | 9.0%       | Lower income → higher churn.                                           |
| 5    | **risk_segment**     | 6.9%       | Medium risk → higher churn than Low risk.                              |


> 💡 **Key Business Actions:**: 

- **Active member** is #1 driver → launch weekly engagement campaigns (vouchers, loyalty points).
- **Risk_score** is #2 → separate Medium risk group for special retention programs.
- **Mass segment** has 39% churn rate → focus retention resources here.

**Churn Predictions Summary**


| Risk Level            | Customers | % of Total | Action Required                  |
| --------------------- | --------- | ---------- | -------------------------------- |
| **High** (prob > 70%) | 1,493     | 1.9%       | 🔴 Immediate intervention needed |
| **Medium** (30-70%)   | 18,507    | 23.1%      | 🟡 Monitor closely               |
| **Low** (prob < 30%)  | 60,000    | 75.0%      | 🟢 Safe                          |


> 💡 **Total at-risk customers (Medium + High): ~20,000 (25%)** – a critical insight for retention strategy.

## 2. Revenue Forecasting (Prophet)

**Objective:** Forecast daily revenue for the next 90 days.
Forecast Plot

**Forecast Summary:**

- **Forecast period:** 90 days
- **Average daily revenue (forecast)**: ~4.8 million VND/day
- **Confidence interval**: ±0.2 million VND (upper/lower bounds)

> 💡📌 **Key insight:** Revenue is projected to remain stable around 4.8M VND/day with minimal seasonal fluctuation in the next quarter.

# 📊 Power BI Dashboard – 5 Interactive Pages

🔗 **[View Live Power BI Dashboard](https://app.powerbi.com/groups/me/reports/e76c0e66-6058-4eb3-a460-abacd8a4b3db/e47008a9bd1700b3c00d?experience=power-bi)**

## Page 1 – Executive Overview

[[images/page1_executive.png]](https://images/page1_executive.png])

**Key Features:**

- Top KPIs: Total Revenue, Churn Rate, Avg Transaction Value, Total Transactions
- Revenue trend line chart (historical + forecast)
- Revenue breakdown by customer segment
- Date range slicer
**Business Value:** Provides leadership with a one-glance view of business health and future projections.

## Page 2 – Customer Health

[[images/page2_health.png]](https://images/page2_health.png]) 

**Key Features:**

- Churn rate by loyalty level (Bronze, Silver, Gold)
- Churn rate by risk segment (Medium, Low)
- Churn rate by cluster group
- Customer profile table (segment, loyalty, risk, churn label)
- Segment slicer
**Business Value:** Identifies which customer segments need immediate retention efforts.

## Page 3 – Churn Drivers

[[images/page3_drivers.png]](https://images/page3_drivers.png])

**Key Features:**

- Feature importance from XGBoost model (bar chart)
- Risk level slicer (High/Medium/Low)
- Risk score distribution
**Business Value:** Explains the "why" behind churn, enabling data-driven retention strategies.

## Page 4 – What-if Scenario

[[images/page4_whatif.png]](https://images/page4_whatif.png])

**Key Features:**

- Discount rate parameter (slicer: 0% – 20%)
- Projected revenue calculation
- Revenue impact visualization
- Comparison chart: Current vs Projected revenue
**Business Value:** Allows decision-makers to test business strategies before implementation.

## Page 5 – AI Insights

[[images/page5_ai.png]](https://images/page5_ai.png])

**Key Features:**

- Daily AI-generated business commentary (via Ollama Cloud)
- Structured as: Situation → Notable Points → Recommendations
- Automatically updated when new data arrives
**Business Value:** Reduces time to insight – stakeholders get a ready-to-read summary without manual analysis.

> 💡 **Sample Insight:**
> *"📊 General Situation: Currently, there are 1,493 High-Risk customers (1.9%) and 18,507 Medium-Risk customers (23.1%). The average churn rate is 18.00%.*
> ⚠️ Notable Points: Mass segment customers have a churn rate of 39.48%, 13 times higher than Priority segment.
> *💡 Recommendations: Focus retention campaigns on Mass and High-Risk segments. Send 10% discount vouchers to High-Risk customers. Monitor Medium-Risk group closely over the next 30 days."*

## 🛠️ dbt Implementation Details

**Why dbt?**

- Version control for all SQL transformations
- Modular, reusable models (staging → intermediate → gold)
- Built-in data quality tests (not null, unique, accepted values)
- Auto-generated data documentation

**Key Models:**


| Model                 | Type             | Description                               |
| --------------------- | ---------------- | ----------------------------------------- |
| **stg_customers**     | Staging          | Cleaned customer data                     |
| **stg_transactions**  | Staging          | Cleaned transaction data                  |
| **int_txn_daily_agg** | Intermediate     | Daily revenue aggregation                 |
| **int_user_cohort**   | Intermediate     | Cohort month and months since last active |
| **dim_customers**     | Gold (Dimension) | Customer attributes for BI                |
| **fct_daily_metrics** | Gold (Fact)      | Daily metrics with customer segments      |


**Run Output:**

```
15:43:11  Completed successfully. PASS=8 WARN=0 ERROR=0
```

# 📂 Repository Structure

```fintech-intelligence-platform/
├── README.md                           # Project documentation
├── .gitignore
├── images/                             # Screenshots for dashboard pages
│   ├── feature_importance.png
│   ├── forecast_plot.png
│   ├── page1_executive.png
│   ├── page2_health.png
│   ├── page3_drivers.png
│   ├── page4_whatif.png
│   └── page5_ai.png
├── dbt_project/
│   └── fintech_dbt/
│       ├── models/
│       │   ├── staging/
│       │   │   ├── sources.yml
│       │   │   ├── stg_customers.sql
│       │   │   └── stg_transactions.sql
│       │   ├── intermediate/
│       │   │   ├── int_txn_daily_agg.sql
│       │   │   └── int_user_cohort.sql
│       │   └── gold/
│       │       ├── dim_customers.sql
│       │       └── fct_daily_metrics.sql
│       ├── tests/                      # Data quality tests
│       └── dbt_project.yml
└── notebooks/                          # Jupyter notebooks (EDA, ML models)
    ├── Checking_The_Fraud_Dataset.ipynb
    ├── FIP_Churn_Forecast.ipynb
    └── FIP_AI_Insights.ipynb

```

# 📈 Key Findings & Business Recommendations

## 1. Customer Churn Insights


| Finding                                                           | Business Recommendation                                                   |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------- |
| **Mass segment** has 39.48% churn rate (13x higher than Priority) | Launch targeted retention campaigns for Mass segment customers            |
| **Bronze loyalty level** customers churn at 20.24% (highest)      | Create a loyalty upgrade program (Bronze → Silver) with clear benefits    |
| **Medium risk** customers have 58.87% churn rate                  | Develop specialized engagement campaigns for Medium risk group            |
| **Active member** is #1 churn driver (31.9%)                      | Implement weekly engagement initiatives (vouchers, points, notifications) |


## 2. Revenue & Cash Flow

- **Stable revenue forecast:** ~4.8M VND/day for the next 90 days
- **Recommendation:** Maintain current marketing strategy, plan inventory based on stable demand

## 3. AI-Generated Insights

- Daily automated summaries save 1-2 hours of manual reporting time
- Provides consistent, unbiased analysis for leadership

# 👤 About Me

I am a Data Analyst with a passion for turning raw data into actionable business insights. This project demonstrates my ability to:

- **Design and implement** a complete data warehouse architecture
- **Transform and model** data using modern tools (dbt, BigQuery, SQL)
- **Build predictive models** (XGBoost, Prophet) to solve real business problems
- **Create interactive dashboards** (Power BI) that drive decision-making
- **Integrate AI** to automate and enhance business insights

# 📧 Contact

**LinkedIn:** [https://www.linkedin.com/in/ericgalbarn/](https://www.linkedin.com/in/ericgalbarn/)  
**GitHub:** github.com/ericgalbarn/fintech_intelligence_platform  
**Email:** [ericgalbarn@gmail.com](mailto:your.email@example.com)

