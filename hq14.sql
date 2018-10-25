set query_group to 'hq14';
set enable_result_cache_for_session to off;

select   100.00 * sum(case when p_type like 'PROMO%'
					then l_extendedprice*(1-l_discount)
					else 0 end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from lineitem, part
where l_partkey = p_partkey
	and l_shipdate >= date '1995-09-01'
	and l_shipdate < date '1995-09-01' + interval '1' month;
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq14' and query = (select max(query) from stl_query where label = 'hq14');
