FROM minimum/openfalcon-golang  
  
MAINTAINER minimum@cepave.com  
  
# Build Open-Falcon Components  
VOLUME /package  
  
RUN \  
apt-get update && \  
apt-get install -y git gcc  
  
COPY openfalcon-build.sh /home/build.sh  
  
# Start  
ENTRYPOINT ["/home/build.sh"]  
CMD ["all"]  

