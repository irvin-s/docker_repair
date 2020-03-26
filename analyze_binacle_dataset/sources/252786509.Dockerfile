FROM debian:8.1  
RUN apt-get update && apt-get install -y tcpflow && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
ENTRYPOINT ["tcpflow"]  

