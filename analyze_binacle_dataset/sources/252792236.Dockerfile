FROM ubuntu:latest  
MAINTAINER whitecat.chayakorn@gmail.com  
  
  
RUN dpkg-divert --local --rename --add /sbin/initctl && \  
ln -sf /bin/true /sbin/initctl && \  
mkdir /var/run/sshd && \  
mkdir /run/php && \  
  
apt-get update && \  
apt-get install -y --no-install-recommends apt-utils \  
software-properties-common \  
python-software-properties \  
language-pack-en-base && \  
  
LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && \  
  
apt-get update && apt-get upgrade -y && \  
#install nginx  
apt-get install -y curl \  
git \  
nano \  
sudo \  
unzip \  
openssh-server \  
openssl \  
  
nginx &&\  
# Install PHP  
apt-get install -y php7.1-fpm \  
php7.1-mysql \  
php7.1-curl \  
php7.1-gd \  
php7.1-intl \  
php7.1-mcrypt \  
php-memcache \  
php7.1-sqlite \  
php7.1-tidy \  
php7.1-xmlrpc \  
php7.1-pgsql \  
php7.1-ldap \  
freetds-common \  
php7.1-pgsql \  
php7.1-sqlite3 \  
php7.1-json \  
php7.1-xml \  
php7.1-mbstring \  
php7.1-soap \  
php7.1-zip \  
php7.1-cli \  
php7.1-sybase \  
php7.1-odbc \  
hhvm  

