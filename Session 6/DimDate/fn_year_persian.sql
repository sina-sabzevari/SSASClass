
ALTER FUNCTION [dbo].[fn_year_persian](@yearnumber INT)
RETURNS TABLE
RETURN

  WITH s AS
  (
    SELECT 
  date,persian_date,d.month_order,d.month_day,date_id,
  CASE 
    WHEN month_order <>12 THEN CONCAT(d.year-@yearnumber , RIGHT(CONCAT('0',d.month_order),2) , RIGHT(CONCAT('0',d.month_day),2)) 
WHEN month_order =12 AND d.month_day<>30  THEN CONCAT(d.year-@yearnumber,'12',RIGHT(CONCAT('0',d.month_day),2))
WHEN month_order =12 AND d.month_day=30  THEN CONCAT(d.year-@yearnumber,'12',29)
  END map_persian_date
  FROM dbo.DimDate d

  )
  SELECT
  s.date,d.date mapping_date
  FROM s
   JOIN dbo.DimDate d ON s.map_persian_date=d.persian_date
GO


