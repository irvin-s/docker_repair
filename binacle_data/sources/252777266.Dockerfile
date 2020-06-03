FROM cesco/debian_base  
  
ARG BUILD_DATE  
ARG VERSION  
LABEL build_version="Cesco - version:- ${VERSION} Build-date:- ${BUILD_DATE}"  
#Update Debian  
RUN \  
apt-get update  
  
# Install required packages  
RUN \  
apt-get install transmission-cli transmission-daemon -y  
  
# add local files  
COPY root/ /  
  
EXPOSE 9091  
VOLUME /config /downloads /movies  

