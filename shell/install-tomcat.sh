#install tomcat
rm -rf /home/hadoop/sw/apache-tomcat-6.0.48.tar.gz
rm -rf /usr/servers/tomcat_1
rm -rf /usr/servers/tomcat_2
echo "clear"

#download
cd /home/hadoop/sw
wget http://mirrors.cnnic.cn/apache/tomcat/tomcat-6/v6.0.48/bin/apache-tomcat-6.0.48.tar.gz

#install
mkdir -p /usr/servers
tar -xvf apache-tomcat-6.0.48.tar.gz -C /usr/servers

cd /usr/servers
mv apache-tomcat-6.0.48 tomcat_1
cp -rf tomcat_1 tomcat_2

cd /usr/servers/tomcat_2/conf
sed -i 's/8080/8081/g' server.xml 
sed -i 's/8005/8006/g' server.xml 

cd /usr/servers
echo """
/usr/servers/tomcat_1/bin/startup.sh
/usr/servers/tomcat_2/bin/startup.sh
""" > start-tomcat.sh

echo """
/usr/servers/tomcat_1/bin/shutdown.sh
/usr/servers/tomcat_2/bin/shutdown.sh
""" > stop-tomcat.sh

chmod +x start-tomcat.sh
chmod +x stop-tomcat.sh

echo "1" > /usr/servers/tomcat_1/webapps/ROOT/test.html
echo "2" > /usr/servers/tomcat_2/webapps/ROOT/test.html
#ps -aux | grep tomcat | grep -v grep | awk '{print $2}' | xargs kill 

