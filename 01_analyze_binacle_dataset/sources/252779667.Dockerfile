FROM alpine:3.7  
COPY ssh.sh /  
  
RUN chmod +x /ssh.sh && \  
apk add --no-cache --update \  
bash \  
ca-certificates \  
openssh-client  
  
ENTRYPOINT ["/ssh.sh"]  

