FROM debian:jessie  
  
MAINTAINER Cristian Lucchesi "cristian.lucchesi@gmail.com"  
ENV NGINX_VERSION 1.8.0-1~jessie  
  
COPY debian/jessie/nginx_${NGINX_VERSION}_amd64.deb .  
  
RUN mkdir /var/log/shibboleth/ && mkdir /var/run/shibboleth/ && \  
apt-get update && \  
apt-get install -y adduser libpcre3 libxml2 libssl1.0.0 \  
supervisor shibboleth-sp2-utils && \  
dpkg -i nginx_${NGINX_VERSION}_amd64.deb && \  
rm -rf /var/lib/apt/lists/* && \  
chown -R _shibd:_shibd /var/log/shibboleth /var/run/shibboleth/  
  
COPY supervisor-shib-deps.conf /etc/supervisor/conf.d/  
COPY start-shibd.sh /  
  
RUN chmod +x /start-shibd.sh  
  
#supervisor needs nginx starting in Foreground  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
  
VOLUME ["/var/cache/nginx"]  
  
EXPOSE 80 443  
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

