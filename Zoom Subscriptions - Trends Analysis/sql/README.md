# Targeted Insights with SQL
Queries to extract insights are found in [zoom insights.sql](https://github.com/zachwong00/data-analytics-projects/blob/main/Zoom%20Subscriptions%20-%20Trends%20Analysis/sql/zoom%20insights.sql).

### Q1: Which month has the highest subscription count in 2020 and 2021?
- In 2020, May has the highest subscription count (11.6K subs)
- In 2021, March has the highest subscription count (10.3K subs)
  
### Q2: Top 5 Countries by Subscription Sale (in USD)
1. United States ($10.44M)
2. United Kingdom ($1.79M)
3. Japan ($1.32M)
4. Canada ($885K)
5. Germany ($866K)

### Q3: Monthly Sales by Plan Type (in USD)
**2020**
- The Pro plan had its highest monthly sales in May at $653K and lowest in February at $245K.
- For Enterprise plan, the highest sales was in March at $545K and lowest in January at $62K.
- Business plan users seen highest sales in April at $288K and lowest in February at $67K.
  
**2021**
- The Pro plan highest monthly sales was in March at $573K and lowest in August at $402K.
- For Enterprise plan, the highest sales was in March at $366K and lowest in July at $160K.
- Business plan users seen highest sales in March at $271K and lowest in Decemebr at $47K.
  
### Q4: Number of Subscribers by Plan and Region
Northen America Region beats all other regions in terms of subscriber count based on plan type.
- Pro users: 94K
- Enterprise users: 4.1K
- Business users: 3.8K
  
### Q5: Subscription Growth by Quarter
**2020**
- Highest Subscription Growth occured in Q2 at 95.58% growth.
- Lowest Subscription Growth was found during Q3, which had a -25.06% decline.
  
**2021**
- Highest Subscription Growth occured in Q1 with a 12.97% growth.
- Lowest Subscription Growth was found in Q3 as well, showing a -16.63% decline.

### Q6: Average Subscription Sales by Region and Quarter
The APAC Region (Western Asia, Eastern Asia, Polynesia, Southern Asia, South East Asia) had the highest average subscription sales overall. 

| Region          | Average Sales | Quarter  |
| --------------- |:-------------:| --------:|
| Western Asia    | $599          | 2021, Q3 |
| Eastern Asia    | $385.41       | 2021, Q2 |
| Polynesia       | $599          | 2020, Q1 |
| Southern Asia   | $200.21       | 2020, Q4 |
| South East Asia | $156.50       | 2020, Q2 |

### Q7: Monthly New Subscribers and Revenue Growth
For 2020, the month of May saw the highest subscribers (11.6K users) while highest revenue growth was in March (200.3% increase)
As for 2021, the highest amount of subscribers (10.3K subs) and revenue growth (16.34% increase) occured in March.

### Q8: Total Sales and Number of Subscribers by Year and Plan
| Year    | Plan Type   | Sales    | Subscribers |
| ------- |:-----------:| --------:| -----------:|
| 2021    | Pro         | $5.57M   | 94.7K       |
| 2020    | Pro         | $5.42M   | 87.8K       |
| 2021    | Enterprise  | $3.36M   | 3.86K       |
| 2020    | Enterprise  | $4.35M   | 5.19K       |
| 2021    | Business    | $2.13M   | 3.82K       |
| 2020    | Business    | $2.48M   | 4.60K       |

### Q9: Who are the Subscribed users with the highest price for each plan type and period?
| User ID   | Plan Type   | Plan Period    | Price |
| ------- |:-----------:| --------:| -----------:|
| 120142089	| Business | Month | 454.3 |
| 122404032	| Pro |	Year | $120 |
| 160924164	| Pro	| Month	| $1.2K |
| 117984323	| Enterprise | Year | $90K |
| 134468209	| Enterprise | Year	| $90K |
| 115059654	| Pro	|	Year 	| $120 |
| 106814347	| Business |	Year | $779.98 |
| 120980938	| Enterprise |	month	| $3.35K |
| 124030270	| Pro	|	Year | $120 |
| 118542542	| Pro	| Year | $120 |
| 122836742	| Pro	| Year | $120 |
