FROM ruby:2.1  
MAINTAINER Peter Mount <peter@retep.org>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# DB Pool size  
ENV DB_POOL 5  
# DB NAME  
ENV DB_NAME thingspeak  
  
# DB User credentials  
ENV DB_USER root  
ENV DB_PASSWORD thingspeak  
  
# DB PostgreSQL host  
ENV DB_HOST thingspeak  
ENV DB_PORT 3306  
# HTTP Port  
ENV HTTP_PORT 80  
# Any value other than no will enable IPv6  
ENV IPV6 no  
  
WORKDIR /opt/  
  
COPY docker-entrypoint.sh /  
  
RUN apt-get update &&\  
apt-get install -y \  
build-essential \  
git \  
libpq-dev &&\  
mkdir -p /opt &&\  
cd /opt &&\  
git clone https://github.com/peter-mount/thingspeak.git &&\  
cd thingspeak &&\  
bundle install &&\  
apt-get remove -y build-essential git &&\  
chmod +x /*.sh &&\  
rm -rf \  
/var/lib/apt/lists/* \  
Dockerfile \  
.git \  
.gitignore  
  
WORKDIR /opt/thingspeak/  
  
#EXPOSE 80  
CMD '/docker-entrypoint.sh'  
  

