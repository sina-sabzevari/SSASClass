
CREATE OR ALTER FUNCTION [dbo].[fn_month_persian](@monthnumber INT)
RETURNS TABLE
RETURN
--DECLARE @monthnumber int=1;
  WITH s AS
  (
    SELECT 
  date,persian_date,d.month_order,d.month_day,date_id,
  CASE 
    WHEN month_order >@monthnumber THEN CONCAT(d.year , RIGHT(CONCAT('0',d.month_order-@monthnumber),2) , RIGHT(CONCAT('0',d.month_day),2)) 
    WHEN d.month_order <@monthnumber AND d.month_day<>31 THEN CONCAT(d.year-1,RIGHT(CONCAT('0',d.month_order+12-@monthnumber),2),RIGHT(CONCAT('0',d.month_day),2)) 
	WHEN month_order <@monthnumber AND d.month_day=31 THEN CONCAT(d.year-1,RIGHT(CONCAT('0',d.month_order+12-@monthnumber),2),30)
  WHEN month_order =@monthnumber AND month_day NOT IN (30,31) THEN CONCAT(d.year-1,RIGHT(CONCAT('0',d.month_order+12-@monthnumber),2),RIGHT(CONCAT('0',d.month_day),2))
WHEN month_order =@monthnumber AND month_day IN (30,31) AND year NOT  IN(1400,1396,1392,1404)  THEN CONCAT(d.year-1,'12',29)
WHEN month_order =@monthnumber AND month_day  IN (30,31) AND year  IN(1400,1396,1392,1404)  THEN CONCAT(d.year-1,'12',30)
  END map_persian_date,'last season' type,'ÝÕá ÞÈá' persian_type
  FROM dbo.DimDate d

  )
  SELECT
  s.date,d.date mapping_date
  FROM s
   JOIN dbo.DimDate d ON s.map_persian_date=d.persian_date
GO


