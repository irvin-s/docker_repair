# Docker container for hmmsearch  
FROM ubuntu  
MAINTAINER Takeru Nakazato, chalkless@gmail.com  
  
RUN apt-get update && \  
apt-get install -y cmatrix && \  
rm -rf /var/lib/apt/lists/*  
  
CMD ["cmatrix"]  
  

