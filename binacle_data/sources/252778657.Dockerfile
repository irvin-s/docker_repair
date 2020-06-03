FROM nginx  
COPY content /usr/share/nginx/html  
COPY conf /etc/nginx  
VOLUME /usr/share/nginx/html  
VOLUME /etc/nginx  
ENTRYPOINT true  

