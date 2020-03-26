FROM jwilder/nginx-proxy:0.3.0  
  
ADD sources.list /etc/apt/security.sources.list  
RUN apt-get update -o Dir::Etc::SourceList=/etc/apt/security.sources.list  
RUN apt-get upgrade -y -o Dir::Etc::SourceList=/etc/apt/security.sources.list  
RUN apt-get clean && rm -r /var/lib/apt/lists/*  

