FROM nginx:1.11-alpine  
  
COPY frontend.conf.template /etc/nginx/conf.d/frontend.conf.template  
  
COPY run.sh /run.sh  
  
CMD ["/bin/sh", "/run.sh"]

