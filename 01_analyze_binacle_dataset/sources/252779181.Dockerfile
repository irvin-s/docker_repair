FROM alpine  
ADD entrypoint.sh /bin/  
RUN apk update  
RUN apk add jq  
RUN chmod +x /bin/entrypoint.sh  
RUN apk -Uuv add curl ca-certificates  
ENTRYPOINT /bin/entrypoint.sh  

