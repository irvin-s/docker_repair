FROM alpine  
ADD docker-registry.conf /docker-registry.conf  
ENV UP_PASSWORD test  
RUN apk --update add nginx apache2-utils \  
&& chown -R nginx /var/lib/nginx/ \  
&& mkdir -p /usr/share/nginx/logs/ \  
&& ln -s /dev/stdout /usr/share/nginx/logs/error.log  
  
EXPOSE 80  
CMD /bin/sh -c '\  
htpasswd -cb /docker-registry.htpasswd up $UP_PASSWORD; \  
nginx -c /docker-registry.conf'  
  

