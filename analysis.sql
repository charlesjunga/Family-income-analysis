SELECT COUNT(*) AS total_households
FROM family_income;
PRAGMA table_info(family_income);

SELECT *FROM family_income
LIMIT 10;

-- Income statistics
SELECT
    COUNT(*) AS total_households,
    ROUND(AVG("Total Household Income"), 2) AS average_income,
    MIN("Total Household Income") AS minimum_income,
    MAX("Total Household Income") AS maximum_income
FROM family_income;

-- Median household income
WITH ranked_income AS (
    SELECT
        "Total Household Income" AS income,
        ROW_NUMBER() OVER (
            ORDER BY "Total Household Income"
        ) AS row_num,
        COUNT(*) OVER () AS total_rows
    FROM family_income
)
SELECT
    AVG(income) AS median_income
FROM ranked_income
WHERE row_num IN (
    (total_rows + 1) / 2,
    (total_rows + 2) / 2
);

-- Compare household income by region
SELECT
    Region,
    COUNT(*) AS total_households,
    ROUND(AVG("Total Household Income"), 2) AS average_income
FROM family_income
GROUP BY Region
ORDER BY average_income DESC;

-- Compare income by education
SELECT
    "Household Head Highest Grade Completed" AS education,
    COUNT(*) AS total_households,
    ROUND(AVG("Total Household Income"), 2) AS average_income
FROM family_income
GROUP BY "Household Head Highest Grade Completed"
HAVING COUNT(*) >= 100
ORDER BY average_income DESC;

-- 10 highest-income households
SELECT
    Region,
    "Household Head Highest Grade Completed" AS education,
    "Total Household Income" AS household_income
FROM family_income
ORDER BY "Total Household Income" DESC
LIMIT 10;

-- Categorise households by income
SELECT
    CASE
        WHEN "Total Household Income" < 100000
            THEN 'Low Income'
        WHEN "Total Household Income" < 300000
            THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_group,
    COUNT(*) AS total_households,
    ROUND(
        AVG("Total Household Income"), 2
    ) AS average_income
FROM family_income
GROUP BY income_group
ORDER BY average_income;

-- Household income by region using median income
WITH ranked AS (
    SELECT
        Region,
        "Total Household Income" AS income,
        ROW_NUMBER() OVER (
            PARTITION BY Region
            ORDER BY "Total Household Income"
        ) AS row_num,
        COUNT(*) OVER (
            PARTITION BY Region
        ) AS region_count
    FROM family_income
)
SELECT
    Region,
    region_count AS total_households,
    ROUND(AVG(income), 2) AS median_income
FROM ranked
WHERE row_num IN (
    (region_count + 1) / 2,
    (region_count + 2) / 2
)
GROUP BY Region
ORDER BY median_income DESC;