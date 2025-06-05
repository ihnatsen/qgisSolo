With path AS(
Select path_id, wkb_geometry, lvl From path),
peaks AS(
Select peaks_id, wkb_geometry From peaks
),
buffer As(
Select peaks_id, ST_Buffer(wkb_geometry, 100) AS wkb_geometry
   From peaks
),
has_point As(
Select path_id, peaks_id
From buffer As p, path As l
Where ST_Contains(p.wkb_geometry, l.wkb_geometry)),

has_no_point AS(
Select Null AS path_id, peaks_id
From peaks 
	Where peaks_id NOT IN (Select peaks_id From has_point))
	
Select path_id::int, peaks_id From has_point	
UNION 
Select path_id::int, peaks_id From has_no_point
Order by path_id
