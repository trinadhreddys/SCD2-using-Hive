#!/bin/bash

#bringing parameter file
. /home/saif/project_2/env/sqp.prm

mv /home/saif/project_2/datasets/Day*.csv /home/saif/project_2/datasets/Day.csv



PASSWD=`sh password.sh`
LOG_DIR=/home/saif/project_2/logs/
DT=`date '+%Y-%m-%d %H:%M:%S'`
DT1=`date '+%Y%m%d'`
LOG_FILE=${LOG_DIR}/project_2_daily.log

mysql --local-infile=1 -uroot -p${PASSWD} < /home/saif/project_2/scripts/sql_daily.txt

if [ $? -eq 0 ]
then echo "sql insertion  and updation successfully executed at ${DT}" >> ${LOG_FILE}
else echo "sql commands failed  at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi

sqoop job --exec pro_job2_imp

if [ $? -eq 0 ]
then echo "sqoop imp job successfully executed at ${DT}" >> ${LOG_FILE}
else echo "sqoop imp job failed  at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi

hive -f /home/saif/project_2/scripts/hive_daily.hql

if [ $? -eq 0 ]
then echo "hive scd successfully executed at ${DT}" >> ${LOG_FILE}
else echo "hive scd job failed  at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi

mysql --local-infile=1 -uroot -p${PASSWD} -e 'truncate table project_2.day_recol;'


if [ $? -eq 0 ]
then echo "day_recol successfully truncated at ${DT}" >> ${LOG_FILE}
else echo "unable to truncate day_recol   at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi


sqoop job --exec pro_job2_exp

if [ $? -eq 0 ]
then echo "sqoop exp job successfully executed at ${DT}" >> ${LOG_FILE}
else echo "sqoop exp job failed  at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi

OUTT=`mysql -uroot -p${PASSWD} -e 'select count(*) from project_2.day where custid not in (select custid from project_2.day_recol);'`
echo ${OUTT}
echo ${OUTT} at ${DT} >> /home/saif/project_2/logs/a.txt 

if [ $? -eq 0 ]
then echo "sql comparison successfully executed at ${DT}" >> ${LOG_FILE}
else echo "sql comparison failed  at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi

mv /home/saif/project_2/datasets/Day*.csv /home/saif/project_2_archive/Day_${DT1}.csv

if [ $? -eq 0 ]
then echo "successfully archived at ${DT}" >> ${LOG_FILE}
else echo "archival failed  at ${DT} " >> ${LOG_FILE}
echo "******************************************************************************************************" >> ${LOG_FILE}
exit 1
fi

echo "******************************************************************************************************" >> ${LOG_FILE}




