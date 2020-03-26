FROM nginx:latest  
  
ADD ./ssl /etc/nginx/ssl  
  
ADD ./nginx_nossl.conf /etc/nginx/  
ADD ./nginx_ssl.conf /etc/nginx/  
ADD ./frontend/dist /static  
ADD ./setupconf.sh /usr/local/bin/setupconf.sh  
CMD ["/usr/local/bin/setupconf.sh"]  

