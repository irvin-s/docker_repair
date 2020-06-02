FROM debian:stable  
MAINTAINER Chamunks <Chamunks@gmail.com>  
  
RUN { \  
## Prepare  
export DEBIAN_FRONTEND=noninteractive; \  
apt-get update; \  
apt-get install -y git build-essential curl python; \  
## Download \  
mkdir -p /usr/src; \  
git clone https://github.com/cjdelisle/cjdns.git /usr/src/cjdns; \  
## Build \  
cd /usr/src/cjdns; \  
: git checkout -f $(git describe --abbrev=0 \--tags --always); \  
./do; \  
## Install \  
install -m755 -oroot -groot /usr/src/cjdns/cjdroute /usr/bin/cjdroute; \  
mkdir -p /etc/cjdns; \  
## Clean \  
apt-get remove -y build-essential curl; \  
apt-get autoremove; \  
apt-get clean; \  
}  
  
COPY entry.sh /entry.sh  
VOLUME /etc/cjdns  
ENTRYPOINT ["/bin/bash", "/entry.sh"]  
CMD ["cjdroute", "--nobg"]  

