#  
# Dockerfile for mini-nginx  
#  
# Start:  
# docker run -d -p PUBLIC_PORT:80 -v HOST_DIR:/var/www dermitch/mini-nginx  
# Debug:  
# docker run -it -p 9000:80 -v /daten:/var/www dermitch/mini-nginx  
#  
FROM ubuntu:14.04  
MAINTAINER Michael Mayr <michael@dermitch.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup; \  
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache; \  
apt-get update;  
  
RUN apt-get install -y --no-install-recommends nginx-light  
  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD default.conf /etc/nginx/sites-enabled/default  
  
EXPOSE 80  
CMD ["nginx"]  

