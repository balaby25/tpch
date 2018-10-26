#!/bin/bash

set -e
set -u

if [ $# != 2 ]; then
    echo "usage : ./runQry.sh  dbhost  hq??  "
    exit 1
fi

export inputSqlDir=/home/balakcha/github/tpch/
export sqlOutDir=/home/balakcha/hqouts/
export DBHOST=$1
export HQID=$2

read up rest </proc/uptime; timeBegin="${up%.*}${up#*.}"

{ time psql \
    -X \
    -U awsmstr \
    -h $DBHOST \
    -p 5439 \
    -v awsmstr \
    -f $inputSqlDir/$HQID.sql \
    -o $sqlOutDir/$HQID.out \
    --echo-all \
    --set AUTOCOMMIT=off \
    --set ON_ERROR_STOP=on \
    -d dev ; }  2>>$sqlOutDir/$HQID.out 

psql_exit_status=$?

read up rest </proc/uptime; timeEnd="${up%.*}${up#*.}"

if [ $psql_exit_status != 0 ]; then
    echo "psql failed while trying to run this sql script" 1>&2
    exit $psql_exit_status
fi

timeMS=$(( 10*($timeEnd - $timeBegin) ))

echo "time_in_millisecs : $timeMS" >> $sqlOutDir/$HQID.out 2>&1

exit 0
