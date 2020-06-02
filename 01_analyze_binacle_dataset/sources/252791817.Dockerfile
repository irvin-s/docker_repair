FROM ubuntu:16.04  
MAINTAINER damon.morgan@gmail.com  
  
RUN apt-get update && apt-get install -y \  
bc \  
build-essential \  
gawk \  
git \  
gperf \  
libncurses5-dev \  
libxml-parser-perl \  
openjdk-9-jre-headless \  
texinfo \  
u-boot-tools \  
unzip \  
wget \  
xfonts-utils \  
xmlstarlet \  
xsltproc \  
zip \  
&& rm -rf /var/lib/apt/lists/*  

