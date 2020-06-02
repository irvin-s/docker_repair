FROM debian:jessie  
  
WORKDIR /opt  
  
# Create directories for the config files  
RUN mkdir -p /opt/tor /opt/privoxy  
  
# Add the config files to the container  
ADD ./privoxy/config /opt/privoxy/config  
ADD ./tor/torrc /opt/tor/torrc  
  
# Update and install the required tools  
RUN apt-get update && apt-get install -y privoxy tor  
  
# Run Tor and Privoxy  
CMD tor -f /opt/tor/torrc && privoxy --no-daemon /opt/privoxy/config  

