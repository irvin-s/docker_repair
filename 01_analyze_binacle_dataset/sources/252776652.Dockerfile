FROM alpine:latest  
COPY rancher /usr/local/bin/  
COPY entrypoint.sh /  
ENV INTERVAL=300  
ENTRYPOINT /entrypoint.sh

