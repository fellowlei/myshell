#install java
source install-java8.sh

# install hadoop
# sw hadoop-2.6.4.tar.gz
cd /home/hadoop/sw
tar -xzvf hadoop-2.6.4.tar.gz -C /usr/local
cd /usr/local
mv hadoop-2.6.4 hadoop
chown -R root:root hadoop

echo """
export HADOOP_HOME=/usr/local/hadoop
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH""" 
>> /etc/profile

source /etc/profile
hadoop version

# config hadoop
cd /usr/local/hadoop/etc/hadoop
#config core-site.xml
echo """<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
        <property>
             <name>hadoop.tmp.dir</name>
             <value>file:/usr/local/hadoop/tmp</value>
             <description>Abase for other temporary directories.</description>
        </property>
        <property>
             <name>fs.defaultFS</name>
             <value>hdfs://localhost:9000</value>
        </property>
</configuration>
""" > core-site.xml
#config hdfs-site.xml
echo """<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
        <property>
             <name>dfs.replication</name>
             <value>1</value>
        </property>
        <property>
             <name>dfs.namenode.name.dir</name>
             <value>file:/usr/local/hadoop/tmp/dfs/name</value>
        </property>
        <property>
             <name>dfs.datanode.data.dir</name>
             <value>file:/usr/local/hadoop/tmp/dfs/data</value>
        </property>
</configuration>
""" > hdfs-site.xml

#hadoop-env.sh
sed -i "s/${JAVA_HOME}/\/usr\/lib\/jvm\/jdk/g" hadoop-env.sh

#config mapred-site.xml
echo """<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
        <property>
             <name>mapreduce.framework.name</name>
             <value>yarn</value>
        </property>
</configuration>
""" > mapred-site.xml

#config yarn-site.xml
echo """<?xml version="1.0" encoding="UTF-8"?>
<configuration>
        <property>
             <name>yarn.nodemanager.aux-services</name>
             <value>mapreduce_shuffle</value>
            </property>
</configuration>
""" > yarn-site.xml


#gen start-hadoop.sh
cd /usr/local/hadoop
echo """
#!/bin/bash
# 启动hadoop
start-dfs.sh
# 启动yarn
start-yarn.sh
# 启动历史服务器,以便在Web中查看任务运行情况
mr-jobhistory-daemon.sh start historyserver
""" > start-hadoop.sh
#gen stop-hadoop.sh
echo """
#!/bin/bash
# 停止历史服务器
mr-jobhistory-daemon.sh stop historyserver
# 停止yarn
stop-yarn.sh
# 停止hadoop
stop-dfs.sh
""" > stop-hadoop.sh

chmod +x start-hadoop.sh
chmod +x stop-hadoop.sh

echo "#################install hadoop over#################"
