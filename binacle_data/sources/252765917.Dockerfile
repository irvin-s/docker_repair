FROM rawmind/hms-jre8:1.8.112  
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>  
  
LABEL Description="HMS Maven Deployer" \  
Vendor="ACME Products" \  
Version="1.0"  
  
# Install rancher cli, remove Docker when done  
RUN set -ex; \  
apk add --update --no-cache git perl-xml-xpath; \  
wget -qO- \  
https://releases.rancher.com/cli/v0.4.1/rancher-linux-amd64-v0.4.1.tar.gz \  
| tar xzv \  
-C /usr/local/bin \  
\--strip-components=2;  
  
# Copy and set entrypoint  
COPY entrypoint /usr/local/bin  
  
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]  
  

