set query_group to 'hq18';
set enable_result_cache_for_session to off;

select  c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice, sum(l_quantity)
from customer, orders, lineitem
where o_orderkey in (
	select l_orderkey
	from lineitem
	group by l_orderkey having sum(l_quantity) > 300
)
	and c_custkey = o_custkey
	and o_orderkey = l_orderkey
group by c_name, c_custkey, o_orderkey, o_orderdate, o_totalprice
order by o_totalprice desc, o_orderdate;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq18' and query = (select max(query) from stl_query where label = 'hq18');
