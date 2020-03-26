FROM carqualifier/docker-nginx-php:php71  
MAINTAINER Eidher Escalona <eescalona@carqualifier.com>  
  
ADD ./container-files/aerospike-client-php-3.4.14.tar.gz /tmp/  
ADD ./container-files/aerospike.ini /etc/php.d/20-aerospike.ini  
  
RUN \  
yum install -y \  
@development \  
openssl-devel && \  
source /etc/profile.d/php71-paths.sh && \  
cd /tmp/aerospike-client-php-3.4.14/src/aerospike && \  
./build.sh && \  
make install && \  
chmod 644 /etc/php.d/20-aerospike.ini && \  
yes '' | pecl install -f mongodb && \  
echo "extension=mongodb.so" >> /etc/php.ini && \  
git clone --depth=1 git://github.com/phalcon/cphalcon.git && \  
cd cphalcon/build && ./install && \  
echo "extension=phalcon.so" >> /etc/php.d/50-phalcon.ini  

