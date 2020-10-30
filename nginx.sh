#! /bin/bash
#
#
#一键安装nginx
yum install -y pcre pcre-devel openssl openssl-devel
cd /data/data && tar -xvf nginx-1.18.0.tar.gz
useradd nginx -s /sbin/nologin 
cd /data/data/nginx-1.18.0 && ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx/ --with-http_stub_status_module --with-http_ssl_module
if [ $? -eq 0 ]
then
       cd /data/data/nginx-1.18.0 && make && make install
        if [ $? -eq 0 ]
        then
             echo "nginx install successful"
        else 
             echo "nginx install error"
         fi
   fi

iptables -F
if [ -d "/usr/local/nginx/sbin/" ]
then 
      cd /usr/local/nginx/sbin/ && ./nginx
      if [ $(netstat -nltp | grep -o 80) -eq 80 ]
      then
           echo "nginx successful..."
       else
           echo "nginx error"
       fi
fi
cat >>/etc/profile <<EOF
export PATH1=/usr/local/nginx/sbin:$PATH1
EOF
source /etc/profile

