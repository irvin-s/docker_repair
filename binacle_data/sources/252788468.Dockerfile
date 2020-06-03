FROM alpine  
MAINTAINER Morten Aasbak loket@cruftlab.io  
  
# Install mos tool dependencies  
RUN apk add --no-cache curl  
  
# Install mos tool  
ADD https://mongoose-os.com/downloads/mos/install.sh /tmp/install-mos.sh  
RUN sh /tmp/install-mos.sh  
  
# Add volume and workdir  
VOLUME /sources/  
WORKDIR /sources/  
  
# Set entrypoint  
ENTRYPOINT ["/root/.mos/bin/mos"]  

