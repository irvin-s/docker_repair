# Generated automatically by update.sh  
# Do no edit this file  
FROM bigtruedata/dump:3.5  
RUN apk add --no-cache mysql-client  
  
COPY mysqldump-entrypoint /usr/local/bin/  
  
VOLUME /dump  
WORKDIR /dump  
  
CMD ["mysqldump-entrypoint"]  

