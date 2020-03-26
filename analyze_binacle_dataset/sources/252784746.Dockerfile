FROM alpine:3.5  
#  
# PACKAGES  
#  
COPY docker-entrypoint.sh /opt/docker-entrypoint.sh  
COPY nginx.conf /nginx/  
RUN apk add --no-cache \  
bash \  
nginx \  
shadow \  
openssl && \  
chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint.sh && \  
usermod -u 10777 nginx && \  
groupmod -g 10777 nginx && \  
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

