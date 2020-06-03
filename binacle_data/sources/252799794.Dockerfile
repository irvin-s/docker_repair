FROM debian:jessie  
MAINTAINER Adam B Hill <adam@diginc.us>  
  
RUN apt-get update && \  
apt-get install -y mumble-server && \  
rm -rf \  
/var/cache/apt/* \  
/var/lib/apt/lists/* \  
  
EXPOSE 64738 64738/udp  
  
ADD ./data/mumble_server.ini /data/  
VOLUME /data  
ENV MUMBLE_INI /data/mumble_server.ini  
  
ADD entrypoint.sh /  
RUN chmod +x entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["-fg"]  

