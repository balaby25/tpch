set query_group to 'hq13';
set enable_result_cache_for_session to off;

select   c_count,   count(*) as custdist   
  from (   
         select   
	     c_custkey,   
	     count(o_orderkey)	as  c_count   
	     from   
	     customer, orders where  
	     c_custkey = o_custkey(+)  
	     and o_comment(+) not like '%special%requests%'  
	     group by  
	     c_custkey  
  	     ) c_orders  
  group by  c_count   
  order by  custdist desc,  c_count desc;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq13' and query = (select max(query) from stl_query where label = 'hq13');
