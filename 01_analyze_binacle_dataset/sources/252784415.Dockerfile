FROM ubuntu:xenial  
MAINTAINER Tim Neumann <mail@timnn.me>  
  
ARG DEBIAN_FRONTEND=noninteractive  
  
ENV LATEXENGINE=lualatex  
ENV PYTHONUNBUFFERED=1  
ADD 01-nodoc.conf /etc/dpkg/dpkg.cfg.d/01-nodoc  
  
RUN apt-get -y update \  
&& apt-get -y upgrade \  
&& apt-get -y install \  
software-properties-common \  
&& apt-get -y install \  
git \  
wget \  
graphviz \  
python3-pip \  
texlive-full \  
curl \  
language-pack-ja \  
&& apt-get -y clean \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN luaotfload-tool --update  
  
VOLUME ["/data"]  
WORKDIR /data  
  
ADD lbuild /usr/local/bin/lbuild  

