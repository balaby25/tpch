copy lineitem from 's3://balabama1/tpch1g/lineitem.tbl' 
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy nation from 's3://balabama1/tpch1g/nation.tbl' 
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy region from 's3://balabama1/tpch1g/region.tbl' 
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy part from 's3://balabama1/tpch1g/part.tbl' 
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy supplier from 's3://balabama1/tpch1g/supplier.tbl' 
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' timeformat 'YYYY-MM-DD HH:MI:SS' region 'us-west-2';

copy partsupp from 's3://balabama1/tpch1g/partsupp.tbl' 
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy customer from 's3://balabama1/tpch1g/customer.tbl'
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';

copy orders from 's3://balabama1/tpch1g/orders.tbl'
credentials 'aws_iam_role=arn:aws:iam::355114326698:role/myRedshiftRole' 
delimiter '|' region 'us-west-2';
