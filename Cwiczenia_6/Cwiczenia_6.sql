--1
with daily_sales as 
(
SELECT
	[OrderDate] 
	,sum([SalesAmount]) as Sales
  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  group by [OrderDate]
)

select
	[OrderDate]
	,Sales
	,avg(Sales) over (order by [OrderDate] rows between 3 preceding and current row ) as Avg_sales
from daily_sales

--2
select month_of_year,
	[0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10]
from 
(
select 
      [SalesTerritoryKey]
      ,[SalesAmount]
	  ,month([OrderDate]) as month_of_year
  from [AdventureWorksDW2019].[dbo].[FactInternetSales]
  where year([OrderDate]) = 2011
) as SourceTable
pivot
(
 sum([SalesAmount])
  for [SalesTerritoryKey] IN ([0],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10])
) as PivotTable
order by month_of_year

--3
SELECT 
      [OrganizationKey]
      ,[DepartmentGroupKey]
      ,sum([Amount])
  FROM [AdventureWorksDW2019].[dbo].[FactFinance]
  group by rollup( [OrganizationKey],[DepartmentGroupKey])
  order by  [OrganizationKey]

--4
SELECT 
      [OrganizationKey]
      ,[DepartmentGroupKey]
      ,sum([Amount])
  FROM [AdventureWorksDW2019].[dbo].[FactFinance]
  group by cube( [OrganizationKey],[DepartmentGroupKey])
  order by  [OrganizationKey]

 --5
  with amount_2011 as
 (
 select [OrganizationKey]
		,sum([Amount]) as SumAmount
 from [AdventureWorksDW2019].[dbo].[FactFinance]
 where year(date) = 2011
 group by [OrganizationKey]
 )

SELECT 
      a.[OrganizationKey]
	  ,a.SumAmount
	  ,o.OrganizationName
	  ,PERCENT_RANK() over(order by SumAmount) as PercentRank
  from amount_2011 a
  join [AdventureWorksDW2019].[dbo].[DimOrganization] o on a.[OrganizationKey] = o.[OrganizationKey]
  order by a.[OrganizationKey]

--6
 with amount_2011 as
 (
 select [OrganizationKey]
		,sum([Amount]) as SumAmount
 from [AdventureWorksDW2019].[dbo].[FactFinance]
 where year(date) = 2011
 group by [OrganizationKey]
 )

SELECT 
      a.[OrganizationKey]
	  ,a.SumAmount
	  ,o.OrganizationName
	  ,percent_rank() over(order by SumAmount) as PercentRank
	  ,stdev(SumAmount) over(order by a.[OrganizationKey]) as Std
  from amount_2011 a
  join [AdventureWorksDW2019].[dbo].[DimOrganization] o on a.[OrganizationKey] = o.[OrganizationKey]
  order by a.[OrganizationKey]

