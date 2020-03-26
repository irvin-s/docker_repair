FROM debian:latest  
  
RUN apt-get update && apt-get install -y open-vm-tools && \  
rm -rf /var/lib/apt/lists/*  
  
ENTRYPOINT ["/usr/bin/vmtoolsd"]  

