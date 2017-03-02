#!/bin/bash

#show databases;
#show tables;
#select * from moneybox;
#create table tb2 as select dt,id,sum(money) from moneybox group by id,dt;

#file name
sqlfile=gen_insert.sql
# gen insert sql
function gen_insert(){
        for ((i=1; i<=5; i++))
        do
           echo "insert into moneybox values('2017-01-0$1 01:00:00','user$1',$100);" >> $sqlfile;
        done
}

#clear sqlfile
echo > $sqlfile

#gen create table
echo "use test;" >> $sqlfile
echo "create table moneybox(dt date,id varchar(20),money int);" >> $sqlfile

#gen insert sql
for ((j=1; j<6; j++))
do
	gen_insert $j
done
echo "gen $sqlfile success"

mysql -uroot -p -e "source $sqlfile"
#mysql -uroot -p -e "source test.sql"
#mysql -uroot -p < test.sql
echo "import $sqlfile to mysql success"



