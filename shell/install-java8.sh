#!/bin/bash  
#sw jdk-8u111-linux-x64.tar.gz
fromdir=/home/hadoop/sw
todir=/usr/lib/jvm
#get install
cd $fromdir
#wget download_url_for_jdk

# install
mkdir $todir
tar -xzvf jdk-8u111-linux-x64.tar.gz -C $todir
cd $todir
mv jdk1.8.0_111 jdk

#add path
echo """
export JAVA_HOME=/usr/lib/jvm/jdk
export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/jre/lib:\$CLASSPATH
export PATH=\$JAVA_HOME/bin:\$JAVA_HOME/jre/bin:\$PATH
""" >> /etc/profile

source /etc/profile

#test
java -version
