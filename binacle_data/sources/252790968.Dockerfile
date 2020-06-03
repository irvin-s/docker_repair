FROM ubuntu:16.04  
MAINTAINER Ryan Pederson <ryan@pederson.ca>  
  
ENV DEBIAN_FRONTEND="noninteractive" \  
TERM="xterm"  
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup &&\  
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \  
apt-get -q update && \  
apt-get -qy --force-yes dist-upgrade && \  
apt-get install -qy --force-yes \  
git-core ca-certificates curl python-lxml openssl xmlstarlet curl sudo \  
software-properties-common  
  
# Clean-up tasks  
RUN apt-get -y autoremove && \  
apt-get -y clean && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /tmp/*  
  
# Create media user / group.  
RUN groupadd -g 4001 media  
RUN useradd -u 4001 -g 4001 media  

