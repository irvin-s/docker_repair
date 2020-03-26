FROM alpine:3.2  
MAINTAINER Azuki <support@azukiapp.com>  
  
ENV BIND_VERSION 9.10.3  
  
# install default packages  
# and build dig and nsupdate  
RUN packages=' \  
bash \  
drill \  
bind-tools \  
' \  
set -x \  
&& apk --update add $packages \  
&& rm -rf /var/cache/apk/*  

