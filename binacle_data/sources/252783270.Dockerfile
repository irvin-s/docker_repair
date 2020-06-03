FROM debian:jessie  
RUN apt-get update && apt-get install -y tor  
COPY torrc /etc/tor/torrc  
ENTRYPOINT tor

