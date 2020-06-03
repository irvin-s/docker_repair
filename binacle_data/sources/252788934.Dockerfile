FROM nginx  
  
  
  
ADD entrypoint.sh /bin/entrypoint.sh  
  
RUN chmod 777 /bin/entrypoint.sh  
  
ADD passwd.conf /etc/nginx/passwd.conf  
  
CMD entrypoint.sh

