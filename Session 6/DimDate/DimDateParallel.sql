



CREATE OR ALTER VIEW [dbo].[V_DimDateParallel]
AS
  SELECT 
  date,date date_mapping,'Default' type,N'پیش فرض' persian_type,1 ordering
  FROM dbo.DimDate
  UNION ALL
    SELECT 
  date,DATEADD(DAY,-1,date),'yesterday' type,'دیروز' persian_type,2 ordering
  FROM dbo.DimDate
    UNION ALL
    SELECT 
  date,DATEADD(DAY,-2,date),'the day before yesterday' type,'پریروز' persian_type,3 ordering
  FROM dbo.DimDate
      UNION ALL
    SELECT 
  date,DATEADD(DAY,-7,date),'last week' type,'هفته قبل' persian_type,4 ordering
  FROM dbo.DimDate
        UNION ALL
    SELECT 
  date,DATEADD(DAY,-14,date),'two weeks ago' type,'دو هفته قبل' persian_type,5 ordering
  FROM dbo.DimDate
UNION ALL
SELECT
date,
mapping_date,
'last month' type,
'ماه قبل' persian_type,6 ordering
FROM dbo.fn_month_persian(1)
UNION ALL
SELECT
date,
mapping_date,
'two monthes ago' type,
'دو ماه قبل' persian_type,7 ordering
FROM dbo.fn_month_persian(2)
UNION ALL
SELECT
date,
mapping_date,
'three monthes ago' type,
'سه ماه قبل' persian_type,8 ordering
FROM dbo.fn_month_persian(3)
UNION ALL
SELECT
date,
mapping_date,
'six month ago' type,
'نیمسال قبل' persian_type,9 ordering
FROM dbo.fn_month_persian(6)
UNION ALL
SELECT
date,
mapping_date,
'last year' type,
'سال قبل' persian_type,10 ordering
FROM dbo.fn_year_persian(1)
UNION ALL
SELECT
date,
mapping_date,
'two years ago' type,
'دو سال قبل' persian_type,11 ordering
FROM dbo.fn_year_persian(2)
UNION ALL
SELECT
date,
mapping_date,
'3 years ago' type,
'سه سال قبل' persian_type,12 ordering
FROM dbo.fn_year_persian(3)
UNION ALL

SELECT d.date,dd.date,'The first day of year' ,N'روز ابتدای سال',13
  FROM [DW].[dbo].[DimDate] d 
  JOIN [DW].[dbo].[DimDate] dd ON d.year=dd.year AND dd.year_day=1
  UNION ALL

SELECT d.date,dd.date,'The first day of season',N'روز ابتدای فصل',14
  FROM [DW].[dbo].[DimDate] d 
  JOIN [DW].[dbo].[DimDate] dd ON d.year=dd.year AND d.season_order=dd.season_order AND dd.season_day=1
  UNION ALL

SELECT d.date,dd.date,'The first day of semester',N'روز ابتدای نیم سال',15
  FROM [DW].[dbo].[DimDate] d 
  JOIN [DW].[dbo].[DimDate] dd ON d.year=dd.year AND d.semester_order=dd.semester_order AND dd.semester_day=1
  UNION ALL
  SELECT d.date,dd.date,'The first day of week',N'روز ابتدای هفته',16
  FROM [DW].[dbo].[DimDate] d 
  JOIN [DW].[dbo].[DimDate] dd ON d.year=dd.year AND d.week_order=dd.week_order AND dd.Week_day_order=1
  UNION ALL
SELECT d.date,dd.date,'The first day of month',N'روز ابتدای ماه',17
  FROM [DW].[dbo].[DimDate] d 
  JOIN [DW].[dbo].[DimDate] dd ON d.year=dd.year AND d.month_order=dd.month_order AND dd.month_day=1

GO


