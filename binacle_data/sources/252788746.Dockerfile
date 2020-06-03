FROM alpine:latest  
  
RUN apk add --no-cache netcat-openbsd && \  
adduser -D -g '' -s /sbin/nologin user  
  
COPY run.sh /usr/local/bin/  
USER user  
EXPOSE 8080  
CMD [ "/usr/local/bin/run.sh" ]  

