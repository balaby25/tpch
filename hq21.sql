set query_group to 'hq21';
set enable_result_cache_for_session to off;

select   s_name, count(*) as numwait
from supplier, lineitem l1, orders, nation
where s_suppkey = l1.l_suppkey
	and o_orderkey = l1.l_orderkey
	and o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select *
		from lineitem l2
		where l2.l_orderkey = l1.l_orderkey and l2.l_suppkey <> l1.l_suppkey
	)
	and not exists (
		select *
		from lineitem l3
		where l3.l_orderkey = l1.l_orderkey and l3.l_suppkey <> l1.l_suppkey and l3.l_receiptdate > l3.l_commitdate
	)
	and s_nationkey = n_nationkey
	and n_name = 'SAUDI ARABIA'
group by s_name
order by numwait desc, s_name;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq21' and query = (select max(query) from stl_query where label = 'hq21');
