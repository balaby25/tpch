set query_group to 'hq20';
set enable_result_cache_for_session to off;

select   s_name, s_address
from supplier, nation
where s_suppkey in (
	select ps_suppkey
	from partsupp
	where ps_partkey in (
		select p_partkey
		from part
		where p_name like 'forest%'
	)
	and ps_availqty > (
		select 0.5 * sum(l_quantity)
		from lineitem
		where l_partkey = ps_partkey
			and l_suppkey = ps_suppkey
			and l_shipdate >= date '1994-01-01'
			and l_shipdate < date '1994-01-01' + interval '1 year'
	)
)
	and s_nationkey = n_nationkey
	and n_name = 'CANADA'
order by s_name;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq20' and query = (select max(query) from stl_query where label = 'hq20');
