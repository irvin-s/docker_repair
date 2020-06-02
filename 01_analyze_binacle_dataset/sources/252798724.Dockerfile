#  
# DesertBit Nginx Dockerfile  
#  
FROM nginx  
  
MAINTAINER Roland Singer, roland.singer@desertbit.com  
  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD includes /etc/nginx/includes  
ADD run.sh /usr/bin/run.sh  
RUN chmod +x /usr/bin/run.sh && \  
mkdir -p /etc/nginx/conf.d && \  
mkdir -p /etc/nginx/certs  
  
VOLUME ["/etc/nginx/conf.d", "/etc/nginx/certs", "/var/log/nginx"]  
  
EXPOSE 80 443  
CMD ["/usr/bin/run.sh"]

