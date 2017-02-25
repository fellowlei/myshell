#!/bin/bash
rm -rf /home/hadoop/sw/openresty-1.9.7.4.tar.gz
rm -rf /usr/local/openresty
echo "clear"
swdir=/home/hadoop/sw
if [ ! -d $swdir ]; then
	mkdir $swdir
fi
cd $swdir
if [ ! -f openresty-1.9.7.4.tar.gz ]; then
	wget https://openresty.org/download/openresty-1.9.7.4.tar.gz
fi
apt-get install libreadline-dev libncurses5-dev libpcre3-dev \
    libssl-dev perl make build-essential -y



tar -zxvf openresty-1.9.7.4.tar.gz
cd openresty-1.9.7.4

./configure --prefix=/usr/local/openresty --with-luajit --with-http_iconv_module 

make -j2
make install
