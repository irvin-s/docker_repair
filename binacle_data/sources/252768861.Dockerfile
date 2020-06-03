FROM debian:jessie  
MAINTAINER Andrew Dunham <andrew@du.nham.ca>  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yy && \  
DEBIAN_FRONTEND=noninteractive apt-get install -yy \  
automake \  
bison \  
build-essential \  
curl \  
file \  
flex \  
git \  
mingw-w64 \  
pkg-config \  
python \  
texinfo \  
vim \  
wget \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build  
  
CMD /bin/bash  

