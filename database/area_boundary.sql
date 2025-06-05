WITH areas AS(
SELECT ST_area(wkb_geometry)/10^6 AS value, 'pl' AS country
	FROM pl_boundary 
UNION 
SELECT ST_area(wkb_geometry)/10^6 AS value, 'sl' AS country
	FROM sl_boundary),

sum_of_tatry AS (
SELECT sum(value) AS the_sum 
	FROM areas)

SELECT round((value/the_sum * 100)::numeric, 2) 
	AS "present_the_area", areas.country 
	FROM sum_of_tatry, areas