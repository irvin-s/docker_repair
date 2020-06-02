FROM nginx:1.13.1-alpine  
  
ENV REDIRECTION_TARGET https://google.de  
  
RUN chmod -R 777 /var/cache/nginx/ && chmod 777 /var/run/ && \  
sed -i "s/user nginx;//g" /etc/nginx/nginx.conf  
  
ADD run.sh /run.sh  
  
EXPOSE 8080  
CMD ["./run.sh"]

