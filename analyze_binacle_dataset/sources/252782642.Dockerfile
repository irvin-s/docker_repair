FROM alpine:3.5  
RUN apk --no-cache add curl jq bash  
COPY register.sh /usr/local/bin/register.sh  
RUN chmod +x /usr/local/bin/register.sh  
  
CMD ["/usr/local/bin/register.sh"]  

