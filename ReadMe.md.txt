# Family Income and Expenditure Analysis (SQL)

## Project Overview
This project uses SQL to analyze household income and expenditure data. The goal is to understand income patterns, compare regions, and explore the relationship between education and household income.

## Tools Used
- SQLite
- Valentina Studio
- SQL

## Dataset
The dataset contains **41,544 households** and 60 columns, including:
- Total household income
- Region
- Household head's highest grade completed
- Household expenditure

The data is from the Family Income and Expenditure Survey dataset. Income values are reported in Philippine pesos (PHP).

## Analysis Questions
1. What is the average, minimum, and maximum household income?
2. What is the median household income?
3. Which regions have the highest average household income?
4. How does household income vary by education level?
5. Which households have the highest recorded incomes?
6. How are households distributed across income groups?
7. How does median income differ across regions?

## SQL Skills Demonstrated
- Aggregate functions: `COUNT()`, `AVG()`, `MIN()`, `MAX()`
- Grouping with `GROUP BY`
- Filtering grouped results with `HAVING`
- Sorting with `ORDER BY`
- Limiting results with `LIMIT`
- Conditional grouping with `CASE`
- Common table expressions (CTEs)
- Window functions: `ROW_NUMBER()` and `COUNT() OVER()`
- Calculating medians using ranked data

## Initial Findings
- The dataset contains 41,544 households.
- Average household income is approximately PHP 247,556.
- Median household income is approximately PHP 164,080.
- NCR's average household income is approximately PHP 420,862.
- NCR's median household income is approximately PHP 312,275.
- The highest education categories can have high average incomes, but some contain relatively few households.

## Project Structure
```text
family-income-analysis/
├── data/
│   └── raw/
├── database/
│   └── family_income.db
├── scripts/
│   ├── analysis.R
│   └── analysis.sql
├── plots/
├── README.md
```

## Conclusion
This project demonstrates how SQL can be used to summarize data, compare groups, identify high-income households, and investigate income patterns. It provides a foundation for further analysis and data visualization.

## Limitations
These are descriptive comparisons. They do not establish that education or region causes higher household income. Results may also be affected by the distribution of incomes and the number of households in each category.
