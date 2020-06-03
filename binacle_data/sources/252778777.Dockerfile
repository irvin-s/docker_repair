FROM ubuntu:16.04  
# setup workdir and update  
RUN mkdir -p /root/work  
WORKDIR /root/work  
  
# add custom repos and update  
RUN apt-get -y update && apt-get -y install software-properties-common  
RUN add-apt-repository -y ppa:git-ftp/ppa  
RUN apt-get -y update  
  
# install git-ftp  
RUN apt-get -y install git git-ftp  
  
# install composer  
RUN apt-get -y install curl php-cli php-curl unzip  
RUN curl -sS https://getcomposer.org/installer | php  
RUN mv composer.phar /usr/local/bin/composer  
  
# slim down image  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# configure volumes  
VOLUME /root/work

