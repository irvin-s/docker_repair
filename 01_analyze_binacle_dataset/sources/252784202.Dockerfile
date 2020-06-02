FROM nginx:alpine  
  
EXPOSE 80  
ADD run.sh /usr/bin/redirectd  
ADD default.conf /etc/nginx/conf.d/default.conf  
  
RUN chmod +x /usr/bin/redirectd  
  
CMD redirectd  

