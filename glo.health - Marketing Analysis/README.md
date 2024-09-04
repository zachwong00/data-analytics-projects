# glo.health Marketing Insights

### Project Goal
Examine the performance of marketing campaigns at glo.health to surface recommendations on marketing budget allocation across future campaign categories.

## Business Objectives & Tasks
glo.health, in 2019, launched a series of marketing campaigns such as health awareness, wellness guidelines, affordability of their plans and preventative care.

glo.health has hired a data analytics team and strategizing their marketing budget for the year. The budget is allocated to drive two main objectives: **1) to increase the number of customer signups**, and **2) to raise awareness of glo.health’s brand across the country**. 

The task is divided into two sections:
- Generate targeted insights from the reimbursement program for the Claims department.
- Understand the effectiveness of these campaign categories and how they relate to signups and subsequent patient claims.

### Dashboard
Click [here](https://public.tableau.com/views/glo_health/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link) for the interactive Tableau dashboard.
![Dashboard (1)](https://github.com/user-attachments/assets/adb682a7-3e3c-4e82-823c-2dc1552afef6)

## Insights

**Signup Rate**
- Based on campaign categories, Health For All campaign had the best performing signup rate (2.08%) and the second highest signup count (3.5K).
- The high signup rates are grounded in its campaign type: Health Awareness, which had the highest signup rates (2.78%) across all campaign types.
- Interestingly, the #HealthyLiving campaign had relatively low signup rates (0.27%) despite having the highest signup counts (3.7K).
- Across platform types, Email are gathering higher signup rates compared to SEO, Social Media and TV. Within Email, Health For All campaign far outperformed other campaigns at 3.72% comapred to <0.06% for others.
  
**Cost per Signup**
- Regarding campaign categories, Golden Years Security had the highest cost per signup ($176.73) and the lowest signups volume (23), compared to an average cost of $3.68. The higher costs are driven by Offer Announcement campaign type.
- #CoverageMatters and Health For All campaigns had the lowest cost values, at $0.65 and $1.23 respectively. 
- Across campaign types, Covid Awareness related campaigns had unusually high costs ($1.2K - $2.3K) with two campaign categories only having 1 signup. Similarly, Summer Wellness Tips under the Health Awareness campaign type had an abnormal high cost ($939.25) and low signups (2).
  
**Click through Rate**
- Across categories, Health For All and Benefit Updates campaigns performed 2-4x better than the average CTR, at 36% and 22% respectively.
- Family Coverage Plan had high impressions but no clicks - further deep-dive is required to determine if it is data and/or campaign issues.
- Based on platforms, Email had 2x more CTR than Social media and SEO, at 16.64% overall. Within Email, Health For All campaign drove the highest CTR (49.26%).
  
**Claims Overview**

_Targeted Insights for the Claims department can be viewed [here]() using SQL._
- Across categories, #CoverageMatters had the the highest claim amount ($1.47M) from customers, while Golden Years Security the lowest at $10K. Interestingly, both campaigns had similar average claim amount at $134 and $136 respectively.
- Overall, #CoverageMatters stands out with consistently higher claim amounts compared to other campaigns, especially from 2021 onwards. However, #HealthyLiving and Health For All also show significant activity, though at a lower level compared to #CoverageMatters.

## Recommendations & Next Steps
- **Prioritize High-Performing Campaigns:** Recommend to reallocate budget from Golden Years Security (due to high costs) and/or #HealthlyLiving to Health For All campaign category or increase its budget by 15-20%, given the strong performance in its marketing efforts. 
- **Reevaluate Low-Performing Campaigns & Platforms:** Decrease investments into #HealthyLiving category, which had the highest spendings ($6.7K) but returns a relatively low signup rate. Reconsider investments for TV platforms as well, which showned poor performance in all key metrics; evaluate either to further decrease spendings or complete abandonement of the platform.
- **Expand Email Marketing for Engagement**: Experiment with A/B testing to half of the customers with 15-20% more emails for 30 days. Compare the metrics at the end of the test if there are significant increases.
- **Covid-type Campaigns:** Investigate Covid Awareness types of campaigns due to its abnormal high costs yet low signups. Consider stopping campaigning altogether in this area partly due to current low Covid search trends as well.
- **Family Coverage Plan:** While this category received ~1M impressions, there is no information on clicks. Engage further with other relevant departments to investigate its issues with possibilities of problems occuring in event tracking or data storage.
