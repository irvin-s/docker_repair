FROM debian:jessie  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm  
  
RUN apt-get update && apt-get install -yqq --no-install-recommends \  
ca-certificates \  
python-pip \  
curl \  
&& pip install awscli \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY docker-entrypoint.sh /  
RUN chmod u+x /docker-entrypoint.sh  
CMD ["start"]  
VOLUME ["/data"]  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

