#!/bin/bash

set -e
set -u

if [ $# != 3 ]; then
    echo "usage : ./runQry.sh  dbhost  /full/path/sqlfile.sql hqx.out "
    exit 1
fi

export DBHOST=$1
export SQLFILEFULLPATH=$2

time psql \
    -X \
    -U awsmstr \
    -h $DBHOST \
    -p 5439 \
    -v awsmstr \
    -f $SQLFILEFULLPATH \
    -o /home/balakcha/hqouts/$3 \
    --echo-all \
    --set AUTOCOMMIT=off \
    --set ON_ERROR_STOP=on \
    -d dev

psql_exit_status=$?

if [ $psql_exit_status != 0 ]; then
    echo "psql failed while trying to run this sql script" 1>&2
    exit $psql_exit_status
fi

echo "sql script successful"
exit 0
