#!/bin/bash

#install hadoop
source install-hadoop.sh

# install scala
# sw scala-2.11.8.tgz
cd /home/hadoop/sw
tar -xzvf scala-2.11.8.tgz -C /usr/local
cd /usr/local
mv scala-2.11.8 scala
chown -R root:root scala

#config
echo """
export SCALA_HOME=/usr/local/scala
export PATH=$SCALA_HOME/bin:$PATH
""" >> /etc/profile

source /etc/profile
#test
scala -version
echo "#################install scala over #################"


# install spark
# sw spark-1.6.1-bin-hadoop2.6.tgz
cd /home/hadoop/sw
tar -zxvf spark-1.6.1-bin-hadoop2.6.tgz -C /usr/local
cd /usr/local
mv spark-1.6.1-bin-hadoop2.6 spark
chown -R root:root spark

#config
echo """
export SPARK_HOME=/usr/local/spark
export PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
""" >> /etc/profile

#config spark-env.sh
cd /usr/local/spark/conf
echo """
export SPARK_DIST_CLASSPATH=$(/usr/local/hadoop/bin/hadoop classpath)
export JAVA_HOME=/usr/lib/jvm/jdk
""" > spark-env.sh

chmod +x spark-env.sh

#test
/usr/local/spark/bin/run-example SparkPi 2>&1 | grep "Pi is roughly"


#gen  start-spark.sh
cd /usr/local/spark

echo """
#!/bin/bash
# 启动Hadoop以及yarn
start-dfs.sh
start-yarn.sh
# 启动历史服务器
mr-jobhistory-daemon.sh start historyserver
# 启动Spark
/usr/local/spark/sbin/start-all.sh
""" > start-spark.sh


echo """
#!/bin/bash
# 停止Spark
/usr/local/spark/sbin/stop-all.sh
# 停止历史服务器
mr-jobhistory-daemon.sh stop historyserver
# 停止Hadoop以及yarn
stop-dfs.sh
stop-yarn.sh
""" > stop-spark.sh

chmod +x start-spark.sh
chmod +x stop-spark.sh

echo "###############install spark over############"



