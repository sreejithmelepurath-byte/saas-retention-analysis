-- ==============================================================================
-- PROJECT: SaaS Cohort Retention & "Leaky Bucket" MRR Analysis
-- AUTHOR: Data Analyst Portfolio
-- DIALECT: PostgreSQL (Standard SQL compliant)
-- DESCRIPTION:
--   Transforms raw user subscription logs (saas_subscriptions) into a 12-month 
--   cohort retention matrix with associated revenue metrics (starting MRR, 
--   retained MRR, lost MRR, and retention percentage).
-- ==============================================================================

WITH cohort_definition AS (
    -- Step 1: Establish the acquisition cohort (signup month) for each user
    SELECT 
        user_id,
        DATE_TRUNC('month', signup_date) AS cohort_month,
        monthly_spend,
        subscription_tier
    FROM saas_subscriptions
),

user_activity AS (
    -- Step 2: Compute the active lifespan duration (in months) relative to signup month
    SELECT 
        s.user_id,
        c.cohort_month,
        c.subscription_tier,
        c.monthly_spend,
        -- Calculate month offset (0 = signup month, 1 = Month 1, etc.)
        (EXTRACT(YEAR FROM s.last_active_date) - EXTRACT(YEAR FROM c.cohort_month)) * 12 + 
        (EXTRACT(MONTH FROM s.last_active_date) - EXTRACT(MONTH FROM c.cohort_month)) AS max_months_active
    FROM saas_subscriptions s
    JOIN cohort_definition c ON s.user_id = c.user_id
),

cohort_sizes AS (
    -- Step 3: Aggregate baseline user counts and starting MRR for each cohort
    SELECT 
        cohort_month,
        COUNT(DISTINCT user_id) AS starting_users,
        SUM(monthly_spend) AS starting_mrr
    FROM cohort_definition
    GROUP BY cohort_month
)

-- Step 4: Construct the final cohort retention matrix
SELECT 
    ua.cohort_month,
    cs.starting_users,
    cs.starting_mrr,
    ua.max_months_active AS month_offset,
    COUNT(DISTINCT ua.user_id) AS users_retained,
    ROUND(
        (COUNT(DISTINCT ua.user_id)::NUMERIC / cs.starting_users) * 100, 2
    ) AS retention_rate_pct,
    SUM(ua.monthly_spend) AS retained_mrr,
    cs.starting_mrr - SUM(ua.monthly_spend) AS lost_mrr
FROM user_activity ua
JOIN cohort_sizes cs ON ua.cohort_month = cs.cohort_month
GROUP BY 
    ua.cohort_month, 
    cs.starting_users, 
    cs.starting_mrr, 
    ua.max_months_active
ORDER BY 
    ua.cohort_month ASC, 
    ua.max_months_active ASC;
