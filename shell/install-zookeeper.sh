#!/bin/bash
#ps -aux | grep zookeeper | grep -v grep | awk '{print $2}' | xargs kill -9
rm -rf /home/hadoop/sw/zookeeper-3.4.9.tar.gz
rm -rf /usr/local/zookeeper
echo "clear"
#get install
if [ ! -d /home/hadoop/sw ]; then
	mkdir -p /home/hadoop/sw
fi
cd /home/hadoop/sw
wget http://mirrors.cnnic.cn/apache/zookeeper/stable/zookeeper-3.4.9.tar.gz

tar -zxvf zookeeper-3.4.9.tar.gz -C /usr/local
cd /usr/local
mv zookeeper-3.4.9 zookeeper 
chown -R root:root zookeeper

#add path
echo """
export ZOOKEEPER_HOME=/usr/local/hive
export PATH=$PATH:$ZOOKEEPER_HOME/bin
""" >> /etc/profile

source /etc/profile

#config zk
cd /usr/local/zookeeper/conf
echo """
tickTime=2000
initLimit=10
syncLimit=5
dataDir=/usr/local/zookeeper/data
dataLogDir=/usr/local/zookeeper/log
clientPort=2181
""" > zoo.cfg

echo "set config ok"
#start zk
/usr/local/zookeeper/bin/zkServer.sh start


