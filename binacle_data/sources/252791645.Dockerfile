FROM debian:jessie  
MAINTAINER Antonios A. Chariton <daknob@daknob.net>  
  
# Update Sources / Upgrade Packages  
RUN apt-get update  
RUN apt-get -y -q upgrade  
  
# Install required software  
RUN apt-get -y -q install tor  
  
# Configure Tor  
RUN mkdir -p /tor/services/  
RUN echo "HiddenServiceDir /tor/services/" > /etc/tor/torrc  
RUN echo "HiddenServicePort 80 hidden.service:80" >> /etc/tor/torrc  
  
# Add and run executable  
COPY tor-proxy /code/tor-proxy  
RUN chmod +x /code/tor-proxy  
CMD ["/code/tor-proxy"]  

