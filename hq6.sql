set query_group to 'hq6';
set enable_result_cache_for_session to off;

select   sum(l_extendedprice*l_discount) as revenue
from lineitem
where l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1' year
	and l_discount between 0.06 - 0.01 and 0.06 + 0.01
	and l_quantity < 24;

select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq6' and query = (select max(query) from stl_query where label = 'hq6');
