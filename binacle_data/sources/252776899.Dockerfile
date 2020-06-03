FROM ubuntu:xenial  
  
# Let the container know that there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
ENV COMPOSER_NO_INTERACTION 1  
# Install tools  
RUN apt-get update \  
&& apt-get -y install zip unzip \  
git build-essential curl \  
software-properties-common  
  
# Install PHP and libraries  
RUN apt-get install -y php7.0 \  
libapache2-mod-php7.0 \  
php7.0-cli \  
php7.0-common \  
php7.0-mbstring \  
php7.0-gd \  
php7.0-xml \  
php7.0-curl \  
php7.0-mcrypt  
  
# Install Composer  
RUN curl -sS https://getcomposer.org/installer \  
-o composer-setup.php \  
&& php composer-setup.php \  
\--install-dir=/usr/local/bin \  
\--filename=composer  
  
# Install Node & NPM  
RUN curl -sL https://deb.nodesource.com/setup_6.x \  
-o nodesource_setup.sh \  
&& bash nodesource_setup.sh \  
&& apt-get -y install nodejs  

