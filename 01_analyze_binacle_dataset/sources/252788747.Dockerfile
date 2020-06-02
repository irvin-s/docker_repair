FROM alpine:latest  
  
RUN apk add --no-cache gnupg && \  
adduser -D -g '' -s /sbin/nologin user  
  
USER user  
ENTRYPOINT [ "/usr/bin/gpg" ]  

