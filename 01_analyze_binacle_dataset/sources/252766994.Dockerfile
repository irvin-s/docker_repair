FROM nginx:alpine  
  
ADD etc/conf.d/* /etc/nginx/conf.d/  
ADD bin/* /usr/local/bin/  
  
RUN set -ex \  
&& ( \  
addgroup \  
-g 82 \  
-S www-data \  
&& adduser \  
-u 82 \  
-D \  
-S \  
-G www-data www-data \  
)  
  
ENV FPM_HOST fpm  
ENV FPM_PORT 9000  
ENTRYPOINT ["/usr/local/bin/docker-environment"]  
CMD ["nginx", "-g", "daemon off;"]  

