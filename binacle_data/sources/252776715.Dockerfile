FROM cbaldwinson/apache2-php7  
MAINTAINER Curtis Baldwinson <curtisbaldwinson@gmail.com>  
  
RUN apt-get update &&\  
apt-get install php7.0-dev libpcre3-dev pkg-config re2c sudo git-core -y  
  
RUN cd /tmp &&\  
git clone https://github.com/phalcon/zephir zephir-ubuntu &&\  
cd zephir-ubuntu &&\  
./install -c  
  
RUN cd /tmp &&\  
git clone http://github.com/phalcon/cphalcon cphalcon &&\  
cd cphalcon &&\  
git checkout 2.1.x &&\  
zephir build --backend=ZendEngine3 &&\  
echo "extension=phalcon.so" >> /etc/php/7.0/apache2/conf.d/30-phalcon.ini &&\  
echo "extension=phalcon.so" >> /etc/php/7.0/cli/conf.d/30-phalcon.ini  
  
EXPOSE 80  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

