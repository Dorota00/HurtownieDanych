-- Moving average
with daily_sales as 
(
SELECT
	cast(date as date) as date
	,sum(amount) as Sales
  FROM [project_prod].[dbo].[Fact_sales]
  group by cast(date as date)
)

select
	date
	,Sales
	,avg(Sales) over (order by date rows between 3 preceding and current row ) as Avg_sales
from daily_sales

-- Top months by amount
select month(date) as Month
	,sum(amount) as SumAmount
	,rank() over( order by sum(amount) desc) as Rank
from Fact_sales f
group by month(date)

-- Top weekdays by amount
select datepart(dw,date) as Weekday
	,sum(amount) as SumAmount
	,PERCENT_RANK() over( order by sum(amount) desc) as PercentRank
from Fact_sales f
group by datepart(dw,date)

-- Carrier comparison by year
select 
		carrier_name as Carrier
		,year(date) as Year
		,sum(amount) as SumAmount
		,rank() over (partition by year(date) order by sum(amount) desc) as Rank
from Fact_sales f
left join DIMCarriers d on f.carrier_id_key = d.id_key
group by cube(carrier_name, year(date))

-- Top customers by frequency
select top(10)
	d.id as CustomerID
	,count(*) as NoOfTransactions
	,percent_rank() over( order by count(*) desc) as PercentRank
from Fact_sales f
left join DIMCustomers d on f.customer_id_key = d.id_key
group by d.id

-- Top states 
select top(10)
	d.state as State
	,sum(amount) as SumAmount
	,percent_rank() over( order by sum(amount) desc) as PercentRank
	,stdev(sum(amount)) over( order by sum(amount) desc) as Stdev
from Fact_sales f
left join DIMCustomers d on f.customer_id_key = d.id_key
group by d.state

