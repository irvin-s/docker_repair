FROM ubuntu:bionic  
  
# helpful packages  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
ca-certificates \  
curl \  
pigz \  
sudo \  
&& rm -rf /var/lib/apt/lists/*  
# add cruise user for least privilege  
RUN useradd -m cruise  
WORKDIR /home/cruise  
USER cruise  

