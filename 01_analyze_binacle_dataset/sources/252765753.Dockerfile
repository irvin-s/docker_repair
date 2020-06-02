FROM 2chat/ubuntu:xenial  
  
RUN apt-get install -y --no-install-recommends stuntman-server && \  
apt-get install -y --no-install-recommends stuntman-client && \  
apt-get clean -y && \  
rm -rf /var/lib/apt/lists/*  
  
EXPOSE 3478/tcp  
EXPOSE 3478/udp  
  
ENTRYPOINT ["/usr/sbin/stunserver"]

