FROM cogentwebs/base  
MAINTAINER Pichate Ins <cogent@cogentwebworks.com>  
  
# Set labels  
LABEL com.caddy.cogentwebworks.version="0.1.1-beta"  
  
# ROOTFS  
COPY rootfs /  
  
RUN addgroup -g 82 -S www-data && adduser -u 82 -D -S -G www-data www-data  
# Install caddy  
RUN apk-install caddy su-exec && apk-clean  
  
# Expose the ports for caddy  
#EXPOSE 80 443 2015  
#VOLUME  
VOLUME ["/usr/html"]  
# INIT S6  
ENTRYPOINT [ "/init" ]

