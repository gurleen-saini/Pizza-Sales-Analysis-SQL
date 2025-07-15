# 🍕 Pizza Sales Analysis – SQL Project

A detailed SQL-driven data exploration project analyzing sales patterns, revenue contributors, popular pizza categories, and order behavior to support business strategy for a fictional pizza chain.

## 📌 Project Overview

This project analyzes a pizza restaurant’s performance by examining key business questions such as:

- What is the total revenue generated and order count?
- Which pizzas are most and least ordered?
- What pizza sizes and categories dominate sales?
- At what time of day are orders most frequent?
- Which pizzas bring in the highest revenue?

The analysis was conducted using **SQL** on a multi-table relational dataset and summarized into insights using structured queries.

## 🧾 Dataset Information

- **Source**: Kaggle – Pizza Sales Dataset

- **Tables Used**:
  - `orders`: Order timestamps and IDs
  - `order_details`: Items per order, including pizza and quantity
  - `pizzas`: Details on pizza size, price, and type
  - `pizza_types`: Pizza names, categories (e.g., Classic, Veggie), and ingredients

- **Time Period**: Full calendar year (simulated)  
- **Total Orders**: 21,000+  
- **Total Pizzas Sold**: ~49,500  

## ⚙️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| 🐘 SQL Server | Data analysis using SQL queries |
| 📊 Power BI | Visualizing sales KPIs |
| 🌐 GitHub | Project versioning and portfolio display |

## 🧠 Key Insights Extracted

- **💰 Revenue Overview**:
  - **Total Revenue**: Computed using `quantity × price` joins across tables
  - **Top 3 Revenue-Generating Pizzas**: Based on total revenue per pizza type

- **🔥 Popular Items**:
  - *Top 5 Most Ordered Pizzas*: Based on total quantity ordered
  - *Most Common Size*: Large pizzas dominated sales volume

- **📦 Category Performance**:
  - *Classic* and *Chicken* categories contributed highest quantities and revenue
  - Category-wise revenue percentage breakdown was calculated

- **🕒 Time-Based Insights**:
  - **Peak Order Hours**: Evening hours (especially 7–8 PM)
  - **Average Pizzas/Day**: ~135 pizzas/day on average

- **📈 Trend Analysis**:
  - Cumulative revenue over time shows growth patterns
  - Top 3 pizzas by revenue per category help focus marketing and promotions

## 🧭 Research Methodology

The project followed a structured workflow:

1. **Schema Understanding** – Studied table relationships, column data types
2. **Data Cleaning** – Used typecasting (e.g., `CAST(... AS VARCHAR)`) to ensure joins work
3. **Exploratory SQL Queries** – JOINs, aggregations, ranking, and subqueries
4. **Trend and KPI Analysis** – Revenue, volume, category-level breakdowns
5. **Insight Generation** – Final insights were used to reflect real-world business use-cases

## 🎓 Project Presentation

📽️ **Power BI Dashboard** & visual storytelling summarizing all findings.  
🔗 [View Canva Report](https://www.canva.com/design/DAGsr7iGDFk/C1NwLtf_OXqrA68Kcl640Q/view?utm_content=DAGsr7iGDFk&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h16a4153e5e)
