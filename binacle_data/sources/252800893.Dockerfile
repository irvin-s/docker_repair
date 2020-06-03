#  
# Dockerfile for Tor Relay Server  
#  
# This will build & install a Tor Debian package using  
# the official instructions for installing Tor on Debian Jessie from source  
# as detailed here https://www.torproject.org/docs/debian.html.en  
#  
# Usage:  
# docker run -d --restart=always -p 9001:9001 chriswayg/tor-server  
FROM debian:stretch  
LABEL MAINTAINER="Edouard COMTET<edouard.comtet@gmail.com>"  
  
# If no Nickname is set, a random string will be added to 'Tor4'  
ENV TOR_NICKNAME=Tor4  
ENV TERM=xterm  
  
RUN apt-get update  
RUN apt-get install -y tor  
RUN apt-get install -y pwgen  
RUN apt-get -y purge --auto-remove  
RUN apt-get clean  
  
# Copy docker-entrypoint  
COPY ./scripts/ /usr/local/bin/  
  
# Persist data  
VOLUME /etc/tor /var/lib/tor  
  
# ORPort, DirPort, ObfsproxyPort  
EXPOSE 9001 9030 54444  
ENTRYPOINT ["docker-entrypoint"]  
  
CMD ["tor", "-f", "/etc/tor/torrc"]

