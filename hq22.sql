set query_group to 'hq22';
set enable_result_cache_for_session to off;

select   cntrycode,   
  	     count(*) as numcust,   
  	     sum(c_acctbal) as totacctbal   
  from  (   
  		     select   
  			     substring(c_phone, 1, 2) as cntrycode,   
  			     c_acctbal   
  		     from  
  			     customer  
  		     where  
  			     substring(c_phone,1, 2) in  
  				     ('13', '31', '23', '29', '30', '18', '17')  
  			     and c_acctbal > (  
  				     select  
  					     avg(c_acctbal)  
  				     from  
  					     customer  
  				     where  
  					     c_acctbal > 0.00  
					     and substring(c_phone, 1, 2) in  
  					     ('13', '31', '23', '29', '30', '18', '17') )  
  		     and not exists (  
  			     select  
  				     *  
  				     from  
  					     orders  
  				     where  
  					     o_custkey = c_custkey )  
  	     ) custsale  
  group by  
 	     cntrycode  
  order by  
  	     cntrycode;

set query_group to 'stlQry';
select query, starttime, endtime , elapsed/1000 as "ElapsedMs", source_query from svl_qlog where label = 'hq22' and query = (select max(query) from stl_query where label = 'hq22');
