FROM nginx  
COPY . /usr/share/nginx/html  
COPY /start.sh /  
  
CMD ["/bin/bash", "/start.sh"]  

