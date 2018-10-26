set query_group to 'hq5';
set enable_result_cache_for_session to off;

select   n_name, sum(l_extendedprice * (1 - l_discount)) as revenue
from customer, orders, lineitem, supplier, nation, region
where c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
        and r_name = 'ASIA'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1 year'
group by n_name
order by revenue desc;

select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq5' and query = (select max(query) from stl_query where label = 'hq5');
