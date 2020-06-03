FROM nginx:1.8.1-alpine  
  
VOLUME ["/srv/www"]  
  
RUN rm /etc/nginx/conf.d/default.conf  
COPY bin/* /usr/local/bin/  
COPY etc/nginx.conf.tmpl /etc/nginx/  
COPY etc/app.conf /etc/nginx/conf.d/  
  
CMD ["/usr/local/bin/start_nginx.sh"]  

