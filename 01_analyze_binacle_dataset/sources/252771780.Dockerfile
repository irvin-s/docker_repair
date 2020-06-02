FROM mono:4.2  
  
MAINTAINER Aurélien Thieriot <a.thieriot@gmail.com>  
  
ENV NUNIT_VERSION=2.6  
  
RUN apt-get update && \  
apt-get install -y nunit=$NUNIT_VERSION\\* && \  
rm -rf /var/lib/apt/lists/*  

