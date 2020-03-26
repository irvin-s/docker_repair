FROM alpine:latest  
MAINTAINER Zimmermann Zsolt  
  
ENV PORT=25565  
ENV MOTD="My cool MC server"  
RUN apk update && apk upgrade && apk --no-cache add socat bash  
COPY ./mclan.sh /bin/  
  
ENTRYPOINT ["/bin/bash /bin/mclan.sh"]  

