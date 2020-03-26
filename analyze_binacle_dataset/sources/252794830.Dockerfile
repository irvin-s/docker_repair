FROM alpine  
MAINTAINER Nikita Vershinin <endeveit@gmail.com>  
  
RUN apk add --update --no-cache curl jq  
  
COPY ["entrypoint.sh","/"]  
  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

