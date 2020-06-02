FROM alpine:latest  
  
MAINTAINER "Anye Labs"  
RUN mkdir -p /data/backup \  
&& mkdir -p /data/logs/nginx/old \  
&& mkdir -p /data/software \  
&& mkdir -p /data/db \  
&& mkdir -p /data/web \  
&& mkdir -p /data/upload \  
&& mkdir -p /data/scripts \  
&& mkdir -p /data/configs/nginx \  
&& mkdir -p /data/logs/nginx/old \  
&& chown -R nobody:root /data/ \  
&& chmod -R g+w /data/  
VOLUME /data  
RUN echo 'This is a data volume docker, located in /data/'  

