FROM alpine:3.5  
MAINTAINER andre@jeanmaire.nl  
  
RUN apk update \  
&& apk add squid \  
&& apk add curl \  
&& apk add openssl \  
&& apk add python3 \  
&& apk add samba-winbind-clients \  
&& rm -rf /var/cache/apk/*  
  
COPY start-squid.sh /usr/local/bin/  
  
RUN chmod +x /usr/local/bin/start-squid.sh  
  
ENTRYPOINT ["/usr/local/bin/start-squid.sh"]  

