FROM ubuntu:14.04  
MAINTAINER ductamnguyen@anduintransact.com  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y software-properties-common && \  
add-apt-repository -y ppa:nginx/stable && \  
apt-get update && \  
apt-get install -y ruby nginx supervisor && \  
gem install fakes3  
RUN mkdir -p /data && rm -rf /etc/nginx  
ADD config/supervisord/supervisord.conf /  
ADD config/nginx /etc/nginx  
  
EXPOSE 4567  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/  
  
CMD exec supervisord -c /supervisord.conf  

