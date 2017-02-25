#!/bin/bash
rm -rf /home/hadoop/sw/apache-maven-3.3.9-bin.tar.gz
rm -rf /usr/local/maven
echo "clear"
weburl=http://mirrors.cnnic.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
filename=apache-maven-3.3.9-bin.tar.gz

if [ ! -d /home/hadoop/sw ];then
	mkdir -p /home/hadoop/sw
fi

cd /home/hadoop/sw
wget $weburl

tar -xvf apache-maven-3.3.9-bin.tar.gz -C /usr/local/

cd /usr/local
mv apache-maven-3.3.9/ maven

echo """export MAVEN_HOME=/usr/local/maven
export PATH=\$PATH:\$MAVEN_HOME/bin
""" >> /etc/profile

echo "import source"
source /etc/profile

mvn -version

echo """
<mirror>  
    <id>alimaven</id>  
    <name>aliyun maven</name>  
    <url>http://maven.aliyun.com/nexus/content/groups/public/</url>  
    <mirrorOf>central</mirrorOf>          
</mirror> 
#setting this to /usr/local/maven/conf/settings.xml
"""  
#mkdir -p /usr/local/maven/tmp
#cd /usr/local/maven/tmp
#mvn archetype:generate -DgroupId=com.mark -DartifactId=myweb -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
#mvn package
#java  -cp target/myweb-1.0-SNAPSHOT.jar com.mark.App 
