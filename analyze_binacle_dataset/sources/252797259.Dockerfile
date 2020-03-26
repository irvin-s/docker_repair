FROM ubuntu:16.04  
MAINTAINER Sascha Falk <sascha@falk-online.eu>  
  
# update image and install additional packages  
ENV DEBIAN_FRONTEND=noninteractive  
RUN \  
apt-get -y update && \  
apt-get -y install software-properties-common && \  
add-apt-repository ppa:certbot/certbot && \  
apt-get -y update && \  
apt-get -y install \  
certbot \  
git \  
iptables \  
lsb-release \  
module-init-tools \  
nano \  
python3 \  
python3-chardet \  
python3-dnspython \  
python3-mako \  
python3-netaddr \  
python3-netifaces \  
python3-openssl \  
supervisor && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# copy prepared files into the image  
COPY target /  
  
# adjust permissions  
RUN \  
chmod 750 /docker-entrypoint.sh && \  
chmod 750 /docker-startup/run-startup.sh  
  
# configure container startup  
ENTRYPOINT [ "/docker-entrypoint.sh" ]  
CMD [ "run" ]  

