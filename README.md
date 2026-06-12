# 🏦 FinTech Intelligence Platform (FIP)

**End-to-end Data Analytics project for a digital bank / FinTech**  
*Churn prediction | Cash flow forecasting | Automated insights | Interactive dashboard*

---

## 📌 Project Overview

| Item | Description |
|------|-------------|
| **Goal** | Build an automated data platform that helps a FinTech company proactively identify customers at risk of churning, forecast cash flow, and generate daily business insights. |
| **Stack** | Google BigQuery (Data Warehouse), dbt (transformation), Airflow (orchestration), Power BI (dashboard), Ollama Cloud (AI insights) |
| **Architecture** | Medallion (Bronze → Silver → Gold) + Hybrid (local orchestration + cloud processing) |
| **Status** | ✅ **Week 1 completed:** Data ingestion, exploration, quality checks, initial insights |

---

## 🎯 Business Problem & Analytical Framework

The project follows a **4‑level analytical framework**:

| Level | Question | Status |
|-------|----------|--------|
| **Descriptive** | Who is churning? | ✅ Completed (see insights below) |
| **Diagnostic** | Why are they churning? | 🔄 In progress (feature engineering & dbt models) |
| **Predictive** | Who will churn next month? | 📅 Planned (XGBoost model) |
| **Prescriptive** | What actions to take? | 📅 Planned (dashboard recommendations + AI insights) |

**Key business metrics targeted:**  
- Reduce churn rate by 10–15%  
- Increase cash flow forecast accuracy >90%  
- Reduce ad‑hoc data question response time from 2 days to <2 minutes

---

## 📊 Data Sources & Medallion Architecture

### Bronze Layer (Raw data)

| Table | Source | Rows | Key columns |
|-------|--------|------|-------------|
| `bronze_customers` | Vietnam Bank Churn Dataset (Kaggle) | 80,000 | `id`, `exit` (churn label), `customer_segment`, `loyalty_level`, `risk_score` |
| `bronze_transactions` | Financial Transaction Fraud Dataset (Kaggle) | 5,000,000 | `transaction_id`, `amount`, `is_fraud`, `location`, `timestamp` |

### Silver / Gold Layers (to be built in Week 3 with dbt)

- **Silver:** Cleaned, deduplicated, standardized data  
- **Gold:** Star schema with `fct_daily_metrics`, `dim_customers`, `forecast`, `insights` – ready for BI

> 🧠 **Why Medallion?** This architecture ensures data quality at each stage, enables incremental processing, and creates a clear separation between raw, cleaned, and business‑ready data.

---

## 🔍 Initial Exploratory Data Analysis (EDA)

After uploading both tables to BigQuery, I performed initial quality checks and business‑focused analysis.

### 1. Data Quality Checks ✅

| Check | Result |
|-------|--------|
| Null values in key columns | ✅ 0% null (`age`, `exit`, `credit_sco`, `balance`, `engagement_score`) |
| Negative transaction amounts | ✅ 0 negative values |
| Fraud rate | 3.59% (179,553 / 5,000,000) – realistic for FinTech |

### 2. Customer Churn Insights (Descriptive Analysis)

**Overall churn rate: 18%** (14,400 / 80,000 customers)

#### Churn rate by customer segment

| Segment | Customers | Churn rate | Risk level |
|---------|-----------|------------|------------|
| **Mass** | 21,436 | **39.48%** | 🔴 High |
| Emerging | 31,662 | 17.62% | 🟡 Medium |
| Affluent | 11,210 | 3.10% | 🟢 Low |
| Priority | 15,692 | 0.07% | 🟢 Very low |

> 💡 **Key finding:** Mass segment has **13x higher churn rate** than Priority segment. This suggests current retention efforts may be over‑focused on VIP customers.

#### Churn rate by loyalty level

| Loyalty level | Customers | Churn rate | Insight |
|---------------|-----------|------------|---------|
| Bronze | 69,252 | 20.24% | Highest churn, largest group |
| Silver | 8,977 | 3.68% | Low churn |
| Gold | 1,771 | 2.82% | Lowest churn |

> 💡 **Key finding:** Loyalty level is a strong predictor of churn. Moving Bronze customers to Silver could significantly reduce churn.

#### Churn rate by risk segment

| Risk segment | Churn rate | Insight |
|--------------|------------|---------|
| Medium | **58.87%** | 🔴 Extremely high risk |
| Low | 15.13% | 🟡 Moderate |

> 💡 **Key finding:** `risk_score` (already provided in the dataset) is a powerful feature. Customers with `risk_segment = Medium` are almost 4x more likely to churn.

#### Churn rate by cluster group

| Cluster | Churn rate | Insight |
|---------|------------|---------|
| 1 | 22.25% | High churn |
| 2 | 22.17% | High churn |
| 4 | 0.05% | Almost no churn |
| 3 | 0.00% | Zero churn |

> 💡 **Key finding:** Clusters 3 and 4 are ideal customer profiles. Analyzing their characteristics will guide acquisition and retention strategies.

### 3. Customer Lifetime Value (LTV) – Roadmap

*Will be calculated in the Gold layer using:*
- **Monetary:** Average transaction amount × frequency
- **Recency:** Time since last active date
- **Tenure:** Customer age (from `created_date`)

> The Gold layer will include `dim_customers` with pre‑computed LTV segments (High, Medium, Low) for use in dashboard filters and targeting.

---

## 🧠 Hypotheses for Diagnostic Analysis (to test in Week 3‑4)

| Hypothesis | Test method | Data needed |
|------------|-------------|-------------|
| H1: Customers inactive for >30 days have much higher churn | Compare churn rate by `last_active_date` bucket | `last_active_date` |
| H2: Low `engagement_score` drives churn in Mass segment | Churn rate by engagement_score decile | `engagement_score` |
| H3: New customers (tenure <6 months) churn faster than older ones | Churn rate by `tenure_ye` | `tenure_ye` |
| H4: Fraud flags correlate with churn (false positives frustrate users) | Churn rate of customers with vs without fraud transactions | `is_fraud` + join |

---

## 🛠️ Technology Stack & Architecture

```text
[Data Sources]
   ├── Kaggle datasets (CSV)
   └── Synthetic transaction generator (Python / Faker)
         │
         ▼
[Google Cloud Platform]
   ├── Cloud Storage → staging area
   ├── BigQuery → Data Warehouse (Bronze / Silver / Gold)
   └── (Week 2) Cloud Run Jobs → dbt & Python scripts
         │
         ▼
[Orchestration] (Week 2‑3)
   └── Airflow (local) or Cloud Scheduler → trigger dbt + ML pipelines
         │
         ▼
[BI & Insights]
   ├── Power BI Service → interactive dashboard (4 pages)
   └── Ollama Cloud → AI‑generated daily insights
