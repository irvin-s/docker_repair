FROM ubuntu:16.04  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get -y install software-properties-common && \  
add-apt-repository -y ppa:ethereum/ethereum && \  
add-apt-repository -y ppa:ethereum/ethereum-dev && \  
apt-get -y update && \  
apt-get -y install ethminer libcurl4-openssl-dev libssl-dev  
  
# Clean up APT when done  
RUN apt-get purge -y build-essential git \  
&& apt-get autoremove -y \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY docker-entrypoint.sh /  
RUN chmod 777 /docker-entrypoint.sh  
  
# Metadata params  
ARG BUILD_DATE  
ARG VERSION  
ARG VCS_URL  
ARG VCS_REF  
# Metadata  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.name="Ethminer" \  
org.label-schema.description="Running ethminer in docker container" \  
org.label-schema.url="https://etherchain.org/" \  
org.label-schema.vcs-url=$VCS_URL \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.vendor="AnyBucket" \  
org.label-schema.version=$VERSION \  
org.label-schema.schema-version="1.0" \  
com.microscaling.docker.dockerfile="/Dockerfile"  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

