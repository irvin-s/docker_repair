FROM callforamerica/debian  
  
MAINTAINER joe <joe@valuphone.com>  
  
ARG REGISTER_SERVICE_VERSION  
  
ENV REGISTER_SERVICE_VERSION=${REGISTER_SERVICE_VERSION:-2.0}  
  
LABEL app.register-service.version=$REGISTER_SERVICE_VERSION \  
app.register-service.type='init-container' \  
app.register-service.app-support='couchdb,bigcouch'  
  
RUN apt-get update && \  
apt-get install curl dnsutils -y && \  
apt-clean --aggressive  
  
# bug with docker hub automated builds when interating with root directory  
# ref: https://forums.docker.com/t/automated-docker-build-fails/22831/27  
# COPY register-service /register-service  
COPY register-service /tmp/  
RUN mv /tmp/register-service /  
  
ENTRYPOINT ["/register-service"]  

