FROM alpine:edge  
  
COPY ./.agent/xssh /usr/local/bin/  
RUN chmod +x /usr/local/bin/xssh && \  
apk add --no-cache openssh-client \  
bash \  
sshpass  
  
COPY ./.agent/ssh/ssh_config /etc/ssh/

