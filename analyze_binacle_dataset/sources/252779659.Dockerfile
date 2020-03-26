FROM comptel/nginx-base:latest  
  
ENV DIRPATH /opt/nxt/cnsl  
  
COPY start-nginx.sh /usr/local/bin/start-nginx.sh  
COPY default-nginx-conf.tmpl /etc/nginx/conf.d/default-conf.tmpl  
  
RUN mkdir -p /var/run/nginx/ && \  
chown -R nginx:nginx \  
/etc/nginx/ \  
/var/log/nginx/ \  
/var/run/nginx/  
  
EXPOSE 8080  
USER nginx  
  
CMD ["start-nginx.sh"]

