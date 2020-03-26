FROM ubuntu:18.04  
LABEL maintainer="dominic.price@nottingham.ac.uk"  
LABEL version="1.0"  
LABEL description="Default version of TeX Live distributed with Ubuntu."  
LABEL os="Ubuntu"  
LABEL os-version="18.04"  
LABEL texlive-version="2017"  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends \  
rsync make texlive-full imagemagick inkscape python-pygments python3-pip \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /root  

