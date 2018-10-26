set query_group to 'hq15';
set enable_result_cache_for_session to off;

with revenue0   
    as (select   
 		     l_suppkey supplier_no,   
  		     sum(l_extendedprice * (1-l_discount)) total_revenue   
  	     from   
  		     lineitem   
  	     where   
  		     l_shipdate >= date '1996-01-01'   
  		     and l_shipdate < date '1996-01-01' + interval '3 month'  
  	     group by  
  		     l_suppkey  
 )  
  select   s_suppkey,  
  	     s_name,  
  	     s_address,  
  	     s_phone,  
  	     total_revenue  
  from  
 	     supplier,  
  	     revenue0  
  where  
  	     s_suppkey = supplier_no  
  	     and total_revenue = (  
  		     select  
  			     max(total_revenue)  
  		     from  
  			     revenue0 )  
  order by  
 	     s_suppkey;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq15' and query = (select max(query) from stl_query where label = 'hq15');
