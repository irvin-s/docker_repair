FROM busybox  
  
RUN mkdir -p /var/www/html  
COPY ./www /var/www/html  
VOLUME /var/www/html  
  
RUN mkdir -p /var/lib/mysql  
  
VOLUME /var/lib/mysql  
  
EXPOSE 22  
CMD ["tail","-f","/dev/null"]  

