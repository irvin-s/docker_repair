FROM rawmind/hms-maven:3.3.9  
MAINTAINER pancho horrillo <pancho@pancho.name>  
  
LABEL Description="Alpine Maven Tester" \  
Vendor="ACME Products" \  
Version="1.0"  
  
# Install xpath, and github-release  
RUN set -ex; \  
apk add --update --no-cache perl-xml-xpath;  
  
# Copy and set entrypoint  
COPY entrypoint /usr/local/bin  
  
ENTRYPOINT [ "/usr/local/bin/entrypoint" ]  
  

