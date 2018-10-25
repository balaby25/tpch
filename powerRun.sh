#!/bin/bash

if [ $# != 1 ]; then
    echo "usage : ./runQry.sh  dbhost "
    exit 1
fi

export inputSqlDir=/home/balakcha/github/tpch/
export sqlOutDir=/home/balakcha/hqouts/
export summaryOut=$sqlOutDir/powerRun.summary
export DBHOST=$1



#for i in  hq1 hq3 hq5 hq6 hq7 hq8 hq10 hq12 hq14 hq19 
#for HQID in  hq1  hq3 hq5
for HQID in  hq6  
do
   cat /dev/null > $sqlOutDir/$HQID.out.aggr
   cat $inputSqlDir/$HQID.sql > $sqlOutDir/$HQID.out.aggr
   for j in  `seq 1 5`
   do
     ./runQry.sh $DBHOST $HQID
     cat $sqlOutDir/$HQID.out >> $sqlOutDir/$HQID.out.aggr
   done

echo -n "$HQID : " >> $summaryOut
awk '/elapsedms/ {getline; getline; print $0}' $sqlOutDir/$HQID.out.aggr |awk -F\| '{ printf "%d , ", $4}' >> $summaryOut
echo "" >> $summaryOut


done
cat $summaryOut
