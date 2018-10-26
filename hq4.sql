set query_group to 'hq4';
set enable_result_cache_for_session to off;

select   o_orderpriority, count(*) as order_count
from orders
where o_orderdate >= date '1993-07-01'
	and o_orderdate < date '1993-07-01' + interval '3 month'
	and exists (
		select *
		from lineitem
		where l_orderkey = o_orderkey and l_commitdate < l_receiptdate
	)
group by o_orderpriority
order by o_orderpriority;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq4' and query = (select max(query) from stl_query where label = 'hq4');
