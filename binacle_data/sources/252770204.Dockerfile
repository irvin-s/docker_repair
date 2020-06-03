FROM debian:jessie  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update && \  
apt-get install -y curl python-setuptools && \  
easy_install supervisor  
  
RUN mkdir -p /var/log/supervisor && \  
mkdir -p /etc/supervisor/conf.d  
  
ADD ./supervisord.conf /etc/supervisord.conf  
  
CMD ["supervisord", "-c", "/etc/supervisord.conf"]  

