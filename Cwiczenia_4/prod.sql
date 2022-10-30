create database cwiczenia4_prod

CREATE TABLE DIMCustomers (
	[idkey] int IDENTITY(1,1),
    [id] varchar(50),
    [first_name] varchar(50),
    [last_name] varchar(50),
    [street] varchar(50),
    [city] varchar(50),
    [state] varchar(50),
    [country] varchar(50),
    [phone] varchar(50),
    [email] varchar(50),
	[eff_start_date] date,
	[eff_end_date] date
)

CREATE TABLE DIMPizzaTypes (
	[idkey] int IDENTITY(1,1),
    [pizza_id] varchar(50),
    [pizza_type_id] varchar(50),
    [size] varchar(50),
    [price] varchar(50),
    [name] varchar(50),
    [category] varchar(50),
    [ingredients] varchar(MAX),
	[eff_start_date] date,
	[eff_end_date] date
)


SELECT TOP 1 [date]
  FROM [cwiczenia4_staging].[dbo].[Orders]
  order by [date]


DECLARE @StartDate  date = '20150101';

DECLARE @CutoffDate date = DATEADD(DAY, -1, DATEADD(YEAR, 10, @StartDate));

;WITH seq(n) AS 
(
  SELECT 0 UNION ALL SELECT n + 1 FROM seq
  WHERE n < DATEDIFF(DAY, @StartDate, @CutoffDate)
),
d(d) AS 
(
  SELECT DATEADD(DAY, n, @StartDate) FROM seq
),
src AS
(
  SELECT
    TheDate         = CONVERT(date, d),
    TheWeek         = DATEPART(WEEK,      d),
    TheMonth        = DATEPART(MONTH,     d),
    TheQuarter      = DATEPART(Quarter,   d),
    TheYear         = DATEPART(YEAR,      d)
  FROM d
)
SELECT * 
	INTO DIMDate
	FROM src
  ORDER BY TheDate
  OPTION (MAXRECURSION 0);

 CREATE TABLE DIMCarrier (
	[idkey] int IDENTITY(1,1),
    [carrier_id] varchar(50),
    [carrier_name] varchar(50),
    [address] varchar(50),
    [tax_id] varchar(50),
    [contact_person] varchar(50),
	[eff_start_date] date,
	[eff_end_date] date
)