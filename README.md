<div align="center">

# Customer Targeting & Campaign Effectiveness Analysis

**Python | MySQL | Pandas | Matplotlib | Seaborn | Excel**

Looked at 2,205 customers across 6 marketing campaigns to figure out who actually responds, which campaigns are worth repeating, and where the company is repeatedly targeting customers who never respond.

The whole point is to end up with one targeting decision table that tells a marketing team exactly who to go after, who to skip, and which campaign to use.

![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.x-4479A1?logo=mysql&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-2.x-150458?logo=pandas&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-3.x-11557C)
![Seaborn](https://img.shields.io/badge/Seaborn-0.13-4C72B0)
![Excel](https://img.shields.io/badge/Excel-Dashboard-217346?logo=microsoftexcel&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?logo=jupyter&logoColor=white)

[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/analytics-ak/marketing-campaign-roi-analysis/blob/main/marketing_campaign_analysis.ipynb)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/analytics-ak/marketing-campaign-roi-analysis/main?labpath=marketing_campaign_analysis.ipynb)

</div>

---

## The Short Version

2,205 customers. 6 campaigns. 13,230 total campaign attempts.

**9,606 of those attempts — 72.6% — went to customers who never responded to a single campaign.**

The budget is not the problem. The targeting is. This analysis finds exactly which customers respond, which campaigns work, and builds a decision table a marketing team can use the same day.

---

## The Core Problem

Most marketing campaigns go out to everyone. Some people respond. Most do not. But nobody goes back and asks — who exactly responded? What do they look like? And how much budget was wasted on people who were never going to convert?

Right now 72.6% of campaign spend is going to non-responders. Within that group, 501 customers spend above average ($1,032 avg) and earn $68K — they are valuable customers, just not reachable through current targeting. That is a targeting gap, not a customer quality problem.

---

## Pipeline

```
MySQL (segmentation + response rates) → Python (profiling + waste detection) → Excel (decision table)
```

MySQL does the heavy lifting on numbers. Python digs deeper into patterns. Excel is what the marketing team actually opens and uses.

---

## The Targeting Decision Table

This is the deliverable. Every segment classified as Target, Test, or Avoid based on response rate thresholds from the data.

| Income | Age | Customers | Response % | Avg Spend | Best Campaign | Action |
|---|---|---|---|---|---|---|
| High (>65K) | Young (<35) | 73 | 50.68% | $1,359 | Campaign 5 | **TARGET** |
| High (>65K) | Senior (>55) | 276 | 44.93% | $1,192 | Last Campaign | **TARGET** |
| High (>65K) | Middle (35-55) | 318 | 43.08% | $1,218 | Last Campaign | **TARGET** |
| Mid (35-65K) | Senior (>55) | 393 | 24.94% | $450 | Last Campaign | TEST |
| Mid (35-65K) | Middle (35-55) | 552 | 22.10% | $353 | Last Campaign | AVOID |
| Mid (35-65K) | Young (<35) | 44 | 18.18% | $419 | Last Campaign | AVOID |
| Low (<35K) | Middle (35-55) | 345 | 16.52% | $63 | Last Campaign | AVOID |
| Low (<35K) | Young (<35) | 102 | 11.76% | $53 | Campaign 3 | AVOID |
| Low (<35K) | Senior (>55) | 102 | 8.82% | $77 | Last Campaign | AVOID |

A marketing team can open this, sort it, and make decisions today.

---

## What the Data Shows

### Income is the strongest targeting signal

High-income customers respond 3x more than low-income ones. Age barely moves the needle within income groups.

| Income Group | Customers | Response Rate |
|---|---|---|
| High (>65K) | 667 | **44.68%** |
| Mid (35-65K) | 989 | 23.05% |
| Low (<35K) | 549 | 14.21% |

The Young + High Income segment has the highest response rate at 50.7% — but only 73 customers. The Senior and Middle High Income segments are more reliable at 276 and 318 customers, both responding above 43%.

---

### One campaign crushed everything. One was basically dead.

Last Campaign pulled 15.1% response rate — double the average. Campaign 2 barely got anyone.

![Campaign Effectiveness](images/campaign_effectiveness.png)

| Campaign | Response Rate | Lift vs Average |
|---|---|---|
| Last Campaign | **15.10%** | +7.6 |
| Campaign 4 | 7.44% | -0.1 |
| Campaign 3 | 7.39% | -0.1 |
| Campaign 5 | 7.30% | -0.2 |
| Campaign 1 | 6.44% | -1.1 |
| Campaign 2 | 1.36% | -6.1 |

14 percentage points separate best from worst. Scale Last Campaign. Cut Campaign 2.

---

### 72.6% of campaign attempts are wasted

1,601 customers never responded to any of the 6 campaigns. Their average income is $47.8K and average spend is $422. They are buying — just not through campaigns. Either wrong channel or wrong offer.

---

### Recency is a reliable secondary filter

![Recency vs Response](images/recency_vs_response.png)

| Recency | Customers | Response Rate |
|---|---|---|
| 0–30 days | 686 | **34.40%** |
| 31–60 days | 645 | 25.58% |
| 61–90 days | 653 | 23.43% |
| 90+ days | 193 | 22.28% |

Practical cutoff — prioritise customers with recency under 60 days. Response rate drops sharply after that window.

---

### Responders look completely different from non-responders

| Metric | Responders | Non-Responders |
|---|---|---|
| Avg Income | $61,719 | $47,813 |
| Avg Total Spend | $937 | $422 |
| Avg Catalog Purchases | 4.13 | 2.08 |
| Avg Web Purchases | 5.08 | 3.73 |
| Avg Store Purchases | 6.60 | 5.53 |
| Avg Recency | 44 days | 51 days |
| Avg Web Visits/Month | 5.06 | **5.44** |

One thing stands out — non-responders visit the website more often. They browse but do not buy. Either the campaigns are not reaching them through the right channel, or the offers do not match what they want.

---

### 501 high-value customers are being missed

501 customers spend above average ($1,032), earn $68K, but never responded to a single campaign. That is 31% of all non-responders — valuable customers the current targeting is failing to reach.

---

## Recommendations

**1. Target high-income customers with Last Campaign**
All three high-income segments respond at 43–51%. Last Campaign performs at 15.1% — double the average. Concentrate budget here first.

**2. Cut low-income segments from active targeting**
Low-income customers respond at 9–17% regardless of age. Cutting spend here frees up budget for segments that actually convert.

**3. Test mid-income seniors separately**
Mid-income seniors respond at 25% — borderline. Worth a small test with Last Campaign before committing full budget. Do not group them with other mid-income segments at 18–22%.

**4. Add recency as a secondary filter**
Customers who purchased in the last 30 days respond at 34.4% — 12 points above the 90+ day group. Layer recency on top of income targeting for highest precision.

**Simple rule: high income + recent purchase + Last Campaign. That is where the return is.**

---

## Conclusion

72.6% of campaign attempts are going to customers who never respond. That is the problem in one number.

The fix is not a new campaign. It is better targeting. High-income customers respond at 43–51%. Low-income customers respond at 9–17%. The gap is large and consistent across every age group.

Redirect budget from low-response segments to high-income recent buyers using Last Campaign — and the same spend produces significantly more conversions without acquiring a single new customer.

This analysis shows that in marketing, who you target matters more than what you say.

---

## Limitations

- 2,205 customers is a small dataset. Patterns should be validated on larger data before major budget decisions.
- Response is not a purchase. No revenue data is available to calculate actual ROI.
- No campaign content or timing data. We know which campaigns worked but not why.
- No control group. True campaign lift cannot be measured without a group that was not targeted.
- Single time snapshot — no seasonal trend analysis possible.

---

## Dataset

- **Source:** [Kaggle — Marketing Campaign Results](https://www.kaggle.com/datasets/jackdaoud/marketing-data)
- **Rows:** 2,205 customers
- **Columns:** 39 (demographics, spending, campaign responses, purchase channels)

---

## Tools Used

| Tool | Used For |
|---|---|
| Python | Data cleaning, feature engineering, analysis |
| MySQL | Segmentation, response rates, aggregation |
| Pandas | Data manipulation and grouping |
| Matplotlib & Seaborn | Charts and visualizations |
| openpyxl | Excel export with formatting and embedded charts |
| Jupyter Notebook | Full end-to-end analysis |

---

## Project Structure

```
marketing-campaign-roi-analysis/
│
├── marketing_campaign_analysis.ipynb  ← Full analysis notebook
├── targeting_recommendations.xlsx     ← Excel deliverable (3 sheets + chart)
├── README.md                          ← You are reading this
│
├── sql/
│   └── queries.sql                    ← All SQL queries standalone
│
└── images/
    ├── campaign_effectiveness.png
    └── recency_vs_response.png
```

---

## How to Run This

1. Clone this repo
   ```bash
   git clone https://github.com/analytics-ak/marketing-campaign-roi-analysis.git
   ```
2. Install required libraries
   ```bash
   pip install pandas numpy matplotlib seaborn mysql-connector-python sqlalchemy openpyxl
   ```
3. Set up MySQL — make sure it is running and update connection credentials in the notebook
4. Open the notebook
   ```bash
   jupyter notebook marketing_campaign_analysis.ipynb
   ```
5. Run all cells — charts generate, data loads into MySQL, Excel file exports automatically

---

## Author

**Ashish Kumar Dongre**

🔗 [LinkedIn](https://www.linkedin.com/in/ashish-kumar-dongre-742a6217b/) &nbsp;|&nbsp; 💻 [GitHub](https://github.com/analytics-ak/marketing-campaign-roi-analysis) &nbsp;|&nbsp; 📂 [Dataset on Kaggle](https://www.kaggle.com/datasets/jackdaoud/marketing-data)
