# Generated automatically by update.sh  
# Do no edit this file  
FROM bigtruedata/cron:3.5  
RUN apk add --no-cache openssl  
  
COPY dump-entrypoint /usr/local/bin/  
  
VOLUME /dump  
WORKDIR /dump  
  
CMD ["dump-entrypoint"]  

