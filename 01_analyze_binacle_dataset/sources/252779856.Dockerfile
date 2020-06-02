FROM alpine:3.6  
LABEL maintainer="https://github.com/connesc"  
  
RUN apk add --no-cache openssh  
  
RUN sed -i 's/^\\(root:.*:\\)[^:]\\+$/\1\/sbin\/nologin/' /etc/passwd  
  
COPY entrypoint.sh /usr/local/bin/  
  
EXPOSE 22  
ENTRYPOINT ["entrypoint.sh"]  

