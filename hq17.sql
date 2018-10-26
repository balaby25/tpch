set query_group to 'hq17';
set enable_result_cache_for_session to off;

select   sum(l_extendedprice) / 7.0 as avg_yearly
from lineitem, part
where p_partkey = l_partkey
	and p_brand = 'Brand#23'
	and p_container = 'MED BOX'
	and l_quantity < (
		select 0.2 * avg(l_quantity)
		from lineitem
		where l_partkey = p_partkey
	);

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq17' and query = (select max(query) from stl_query where label = 'hq17');
