FROM alpine:3.5  
#  
# PACKAGES  
#  
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh  
COPY nginx.conf.jinja2 /nginx/  
RUN apk add --no-cache \  
bash \  
nginx \  
shadow \  
openssl \  
python \  
py-pip && \  
pip install shinto-cli && \  
chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint.sh && \  
usermod -u 10000 nginx && \  
groupmod -g 10000 nginx && \  
mkdir -p /opt/www && \  
mkdir -p /opt/ssl && \  
chown -R nginx:nginx /opt/ && \  
mkdir -p /nginx/tmp/ && \  
chown -R nginx:nginx /nginx/  
  
#  
# RUN NGINX  
#  
USER nginx  
EXPOSE 4443  
VOLUME ["/opt/www"]  
WORKDIR /opt/www/  
ENTRYPOINT ["/opt/docker-entrypoint.sh"]  
CMD ["nginx", "-c", "/nginx/nginx.conf", "-g", "daemon off;"]  

