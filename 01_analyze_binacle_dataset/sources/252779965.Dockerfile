FROM ubuntu:15.10  
MAINTAINER Yusuke Suzuki <utatane.tea@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -y update  
RUN apt-get -y upgrade  
RUN apt-get install -y \  
texlive \  
texlive-base \  
texlive-lang-cjk \  
texlive-fonts-recommended \  
texlive-fonts-extra \  
texlive-xetex \  
fontconfig \  
fonts-takao-pgothic \  
fonts-takao-gothic \  
fonts-takao-mincho \  
python-pygments \  
unzip \  
wget \  
curl \  
git \  
build-essential  
  
ENV DEBIAN_FRONTEND dialog  
CMD /bin/bash  

