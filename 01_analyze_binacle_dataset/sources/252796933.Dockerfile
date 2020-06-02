FROM ubuntu:14.04  
MAINTAINER Synctree Appforce  
  
RUN apt-get update \  
&& apt-get install -y supervisor \  
curl \  
git \  
&& apt-get clean  
  
# Installing node 6.x  
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \  
&& apt-get update \  
&& apt-get install -y nodejs \  
&& apt-get clean  
  
RUN mkdir -p /usr/src/es-proxy /etc/supervisor/conf.d /root/.aws  
  
WORKDIR /usr/src/es-proxy  
  
ADD package.json /usr/src/es-proxy/  
RUN npm install  
  
ADD es-proxy.js /usr/src/es-proxy/  
ADD docker/usr/bin/* /usr/bin/  
ADD docker/etc/supervisor/conf.d/* /etc/supervisor/conf.d/  
  
EXPOSE 9200  
ADD docker/docker-entrypoint.sh /  
ENTRYPOINT [ "/docker-entrypoint.sh" ]  
  
CMD [ "es-proxy" ]  

