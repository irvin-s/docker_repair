FROM postgres:9.6  
MAINTAINER Peter Mount <peter@retep.org>  
  
# Enforce we have locales present to prevent issue where DB won't restart  
# with the container due to it requiring a non-existent locale  
  
ENV LANG=en_US.UTF-8  
  
RUN mkdir -p /docker-entrypoint-initdb.d &&\  
apt-get update &&\  
apt-get upgrade -y &&\  
apt-get install -y \  
tzdata \  
locales &&\  
sed -i -r "s/# (.+)_/\1_/g" /etc/locale.gen &&\  
dpkg-reconfigure \--frontend=noninteractive locales &&\  
update-locale LANG=$LANG  
  
COPY *.sh /docker-entrypoint-initdb.d/  

