#  
# Dockerfile for Docker Registry with grsecurity kernel  
#  
# VERSION 2.3.0  
FROM registry:2.3.0  
RUN apt-get update && apt-get install attr \  
&& apt-get clean && rm -rf /var/lib/apt/lists/*  
  
ADD registry /usr/local/bin/registry  
RUN chmod +x /usr/local/bin/registry  
  
ENTRYPOINT ["/usr/local/bin/registry"]  
CMD ["/etc/docker/registry/config.yml"]  

