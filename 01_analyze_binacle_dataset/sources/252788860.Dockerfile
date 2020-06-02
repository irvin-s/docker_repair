FROM sickp/alpine-sshd  
MAINTAINER Christian Nolte <hello@noltech.net>  
  
RUN apk --update add openssh \  
&& sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config \  
&& rm -rf /var/cache/apk/*  
  
COPY docker-entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT /entrypoint.sh  
  
EXPOSE 22  

