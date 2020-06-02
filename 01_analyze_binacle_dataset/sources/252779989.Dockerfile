FROM alpine:3.7  
RUN apk add \--no-cache ca-certificates git openssh-client curl \  
&& [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

