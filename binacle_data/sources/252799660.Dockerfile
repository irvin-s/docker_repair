FROM alpine:3.3  
MAINTAINER Pauli Jokela <pauli.jokela@didstopia.com>  
  
# Install updates  
RUN apk upgrade --update  
  
# Install dependencies  
RUN apk add \  
git \  
python \  
py-imaging  
  
# Copy necessary scripts  
COPY start-plexconnect.sh /opt/start.sh  
  
# Download PlexConnect  
RUN git clone https://github.com/iBaa/PlexConnect.git /opt/PlexConnect  
  
# Setup logging  
RUN ln -sf /dev/stdout /opt/PlexConnect/PlexConnect.log  
  
# Setup volume for SSL certificates  
VOLUME /plexconnect  
  
# Run cleanup  
RUN rm -rf /var/cache/apk/*  
  
# Finally set the startup command  
ENTRYPOINT /opt/start.sh  

