import pandas as pd
import numpy as np
from datetime import datetime, timedelta

# Set random seed for reproducibility
np.random.seed(42)

# Generate 10,000 users
n_users = 10000
user_ids = range(1, n_users + 1)

# Generate realistic sign-up dates over the last 12 months
start_date = pd.to_datetime('2025-01-01')
signup_dates = [start_date + timedelta(days=np.random.randint(0, 365)) for _ in range(n_users)]

# Simulate churn: ~60% churn eventually, with a heavy drop-off around 3 months
churned = np.random.choice([True, False], size=n_users, p=[0.6, 0.4])
active_days = np.random.gamma(shape=2, scale=45, size=n_users) # Creates a realistic skewed drop-off

last_active_dates = []
for i in range(n_users):
    if churned[i]:
        # Cap churn date to today if it goes into the future
        churn_date = signup_dates[i] + timedelta(days=active_days[i])
        last_active_dates.append(min(pd.to_datetime('2026-07-27'), churn_date))
    else:
        last_active_dates.append(pd.to_datetime('2026-07-27')) # Still active today

# Assign subscription tiers and MRR
tiers = np.random.choice(['Basic', 'Pro', 'Enterprise'], size=n_users, p=[0.7, 0.25, 0.05])
spend_map = {'Basic': 15, 'Pro': 49, 'Enterprise': 199}
monthly_spend = [spend_map[t] for t in tiers]

# Create DataFrame
df = pd.DataFrame({
    'user_id': user_ids,
    'signup_date': signup_dates,
    'last_active_date': last_active_dates,
    'subscription_tier': tiers,
    'monthly_spend': monthly_spend,
    'is_churned': churned
})

df.to_csv('saas_subscriptions.csv', index=False)
print("Dataset generated successfully!")