FROM alpine:3.6  
RUN apk add --update curl bash jq \  
&& rm -rf /var/cache/apk/*  
  
COPY kashing.sh /bin/kashing.sh  
RUN chmod +x /bin/kashing.sh  
  
COPY cron/root /var/spool/cron/crontabs/root  
  
CMD crond -l 2 -f  

