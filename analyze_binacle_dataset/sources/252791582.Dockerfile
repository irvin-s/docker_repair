FROM dahus/docker-nodejs  
RUN apt install -y nginx  
COPY nginx.conf /etc/nginx/nginx-template  
COPY startup.sh /startup.sh  
RUN chmod u+x /startup.sh  
ENTRYPOINT ["/startup.sh"]  

