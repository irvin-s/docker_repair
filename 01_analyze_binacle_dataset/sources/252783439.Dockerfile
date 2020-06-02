FROM oberthur/docker-alpine-java:jdk8_8.66.18  
  
MAINTAINER Victor Zhivotikov <deathman1912@gmail.com>  
  
ENV HOME=/opt/app  
  
WORKDIR /opt/app  
  
# Add user app  
RUN addgroup -g 499 app \  
&& adduser -u 499 -G app -s /bin/false -h /opt/app -D app \  
&& mkdir -p /opt/app/logs/archives \  
&& chown -R app:app /opt/app

