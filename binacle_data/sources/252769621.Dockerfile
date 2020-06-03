FROM ubuntu:14.04  
MAINTAINER Takuya Arita <takuya.arita@gmail.com>  
  
RUN \  
locale-gen en_US.UTF-8 && \  
export LANG=en_US.UTF-8 && \  
apt-get update && \  
apt-get install -y software-properties-common git && \  
add-apt-repository -y ppa:ondrej/php && \  
apt-get update && \  
apt-get install -y \  
php5.6-cli \  
php5.6-dev \  
php5.6-mysql \  
php5.6-curl \  
php5.6-zip \  
php5.6-xml \  
php5.6-mbstring \  
gcc \  
libpcre3-dev && \  
git clone --depth=1 git://github.com/phalcon/cphalcon.git && \  
cd cphalcon/build && \  
./install && \  
echo "extension=phalcon.so" > /etc/php/5.6/cli/conf.d/99-phalcon.ini && \  
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \  
php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \  
composer global require hirak/prestissimo && \  
apt-get remove -y php5.6-dev gcc libpcre3-dev software-properties-common && \  
apt-get autoremove -y  
  
CMD ["/bin/bash"]  

