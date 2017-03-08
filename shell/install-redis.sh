cd /home/hadoop/sw
[ ! -f redis-3.2.8.tar.gz ] && wget http://download.redis.io/releases/redis-3.2.8.tar.gz
#[ -d /usr/servers/redis-3.2.8 ] && rm -rf /usr/servers/redis-3.2.8
tar -xvf redis-3.2.8.tar.gz -C /usr/servers
cd /usr/servers/
mv redis-3.2.8 redis
cd redis
make 

#gen sh
echo """
/usr/servers/redis/src/redis-server --port 6379 --daemonize yes
/usr/servers/redis/src/redis-server --port 6380 --daemonize yes
""" > start-redis.sh

echo """
ps -ef | grep redis-server | grep -v grep | awk '{print \$2}' | xargs kill 
""" > stop-redis.sh
chmod +x start-redis.sh
chmod +x stop-redis.sh

