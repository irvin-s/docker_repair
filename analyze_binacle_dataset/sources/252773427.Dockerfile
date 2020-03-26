# Generated automatically by update.sh  
# Do no edit this file  
FROM bigtruedata/alpine:3.4  
RUN apk add --no-cache bash tzdata  
  
COPY cron-entrypoint /usr/local/bin/  
  
CMD ["cron-entrypoint"]  

