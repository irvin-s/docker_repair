FROM alpine:3.6  
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>  
  
LABEL Description="iptables configurator" \  
Vendor="ACME Products" \  
Version="1.0"  
  
COPY entrypoint /  
  
ENTRYPOINT [ "/entrypoint" ]  
  
RUN set -ex; \  
apk add --no-cache iptables  

