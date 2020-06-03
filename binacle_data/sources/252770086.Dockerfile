FROM resin/raspberry-pi-python:3  
# FROM resin/raspberry-pi-python:3-onbuild  
# Enable crossbuild so ARMHF images can be built on x86  
# https://docs.resin.io/runtime/resin-base-images/#resin-xbuild-qemu  
RUN [ "cross-build-start" ]  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends motion && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /mnt/motion && \  
chown motion /mnt/motion  
  
COPY motion.conf /etc/motion/motion.conf  
  
EXPOSE 8081  
ENTRYPOINT ["motion"]  
  
RUN [ "cross-build-end" ]  

