FROM alpine  
MAINTAINER pao0111@gmail.com  
  
RUN apk update && apk add yarn  
  
WORKDIR "/app"  
VOLUME ["/app"]  
  
ENTRYPOINT ["yarn"]  

