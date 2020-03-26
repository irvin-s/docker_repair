FROM rawmind/hms-maven:3.3.9  
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>  
  
LABEL Description="HMS Maven Packer" \  
Vendor="ACME Products" \  
Version="1.0"  
  
# Install docker  
RUN set -ex; \  
apk add --update --no-cache perl-xml-xpath docker;  
# Copy and set entrypoint  
COPY entrypoint /usr/local/bin  
  
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]  
  

