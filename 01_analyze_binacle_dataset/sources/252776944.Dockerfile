FROM ubuntu:latest  
MAINTAINER Ceaser Larry  
  
# Set build arguments.  
ARG DEB_PROXY  
ENV DEB_PROXY ${DEB_PROXY}  
  
# Optional APT Proxy  
RUN [ -z "$DEB_PROXY" ] || \  
echo "Acquire::http::Proxy \"$DEB_PROXY\";" > /etc/apt/apt.conf.d/01proxy && \  
echo "Acquire::https::Proxy false;" >> /etc/apt/apt.conf.d/01proxy  
  
RUN set -ex \  
# Install dependencies.  
&& apt-get update \  
&& apt-get install -y \  
awscli \  
ca-certificates \  
  
# cleanup  
&& apt-get purge -y unzip apt-transport-https wget \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/apt/apt.conf.d/01proxy  
  
# Copy entrypoint script.  
COPY /docker-entrypoint.sh /  
  
# Set entrypoint and default command.  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  

