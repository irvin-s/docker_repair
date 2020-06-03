FROM 221robotics/armv7hf-debian-qemu  
  
RUN [ "cross-build-start" ]  
  
RUN apt-get update && \  
apt-get install -y git wget ssh-client && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
# copy in scripts  
COPY ./entrypoint.sh /entrypoint.sh  
  
# make the scripts executable  
RUN chmod +x /entrypoint.sh  
  
CMD [ "/entrypoint.sh" ]  
  
RUN [ "cross-build-end" ]  

