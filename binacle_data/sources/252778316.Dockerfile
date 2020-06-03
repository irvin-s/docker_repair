# -*- mode: ruby -*-  
# vi: set ft=ruby :  
FROM aquabiota/openjdk-8-phusion-baseimage:16.04  
LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"  
  
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \  
locale-gen  
  
RUN apt-get update --fix-missing && \  
apt-get -yq dist-upgrade && \  
apt-get install -yq --no-install-recommends \  
wget \  
bzip2 \  
ca-certificates \  
python3-pip \  
software-properties-common \  
git \  
curl \  
locales  
  
CMD ["/sbin/my_init"]  
  
# # Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*  
# Added a health check  
# HEALTHCHECK CMD curl --fail http://localhost:2480/ || exit 1  

