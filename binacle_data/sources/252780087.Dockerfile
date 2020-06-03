FROM debian:jessie  
MAINTAINER Patrick Easters <peasters@ayetier.com>  
  
# Let the conatiner know that there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install software requirements  
RUN apt-get update && \  
apt-get update && \  
apt-get upgrade -y && \  
apt-get autoremove -y && \  
apt-get clean && \  
apt-get autoclean && \  
echo -n > /var/lib/apt/extended_states && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /usr/share/man/?? && \  
rm -rf /usr/share/man/??_*  

