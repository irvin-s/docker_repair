FROM ubuntu:16.04  
RUN \  
apt-get update && \  
apt-get install -y sigil && \  
rm -rf /var/lib/apt/lists/*  
  
RUN adduser sigil  
  
USER sigil  
ENV HOME /home/sigil  
  
CMD []  
ENTRYPOINT ["/usr/bin/sigil"]

