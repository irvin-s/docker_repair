FROM alpine:3.6  
LABEL maintainer="Luke Bennett - https://lukebennett.com"  
ENTRYPOINT ["/entrypoint.sh"]  
EXPOSE 22  
RUN apk add --no-cache openssh curl \  
&& cp /etc/ssh/sshd_config /sshd_config.orig  
VOLUME /etc/ssh  
COPY entrypoint.sh /  

