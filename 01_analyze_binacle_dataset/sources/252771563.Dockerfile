FROM ubuntu:14.04  
MAINTAINER Dmitry Sinev <astartsky@gmail.com>  
ENV DEBIAN_FRONTEND=noninteractive \  
REFRESHED_AT=2015_09_03  
  
# install custom repositories  
RUN apt-get update && apt-get install -y software-properties-common && \  
add-apt-repository -y ppa:nginx/stable  
  
# install packages  
RUN apt-get update && apt-get install -y \  
nginx  
  
# configure nginx  
RUN rm /etc/nginx/sites-enabled/default && \  
echo "\ndaemon off;" >> /etc/nginx/nginx.conf  
  
# cleanup  
RUN apt-get clean && rm -rf /var/lib/apt/lists/*  
  
VOLUME ["/var/www"]  
WORKDIR /var/www  
  
EXPOSE 80  
CMD ["/usr/sbin/nginx"]  

