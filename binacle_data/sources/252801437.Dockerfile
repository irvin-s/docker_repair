FROM ubuntu:14.04  
# nginx  
RUN apt-get update  
RUN apt-get install nginx -y  
  
# install confd  
COPY confd /usr/local/bin/  
RUN chmod +x /usr/local/bin/confd  
  
# confd templates  
RUN mkdir -p /etc/confd/{conf.d,templates}  
COPY nginx.toml /etc/confd/conf.d/  
COPY nginx.tmpl /etc/confd/templates/  
  
# confd-watch  
COPY confd-watch /usr/local/bin/  
RUN chmod +x /usr/local/bin/confd-watch  
  
# remove the default nginx config  
RUN rm /etc/nginx/sites-enabled/default  
  
# copy the main nginx config file  
COPY nginx.conf /etc/nginx/  
  
EXPOSE 80  
CMD ["/bin/bash"]  

