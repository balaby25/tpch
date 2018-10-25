set query_group to 'hq10';
set enable_result_cache_for_session to off;

select c_custkey, c_name, sum(l_extendedprice * (1 - l_discount)) as revenue, c_acctbal, n_name, c_address, c_phone, c_comment
from customer, orders, lineitem, nation
where c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and o_orderdate >= date '1993-10-01' and o_orderdate < date '1993-10-01' + interval '3' month
	and l_returnflag = 'R'
	and c_nationkey = n_nationkey
group by c_custkey, c_name, c_acctbal, c_phone, n_name, c_address, c_comment
order by revenue desc;


set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq10' and query = (select max(query) from stl_query where label = 'hq10');
