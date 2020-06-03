FROM sillelien/base-alpine:0.10  
RUN apk update  
RUN apk add --update bash curl && rm -rf /var/cache/apk/*  
  
COPY timer.sh /timer.sh  
RUN chmod +x /timer.sh  
  
CMD ["/bin/bash", "/timer.sh"]  

