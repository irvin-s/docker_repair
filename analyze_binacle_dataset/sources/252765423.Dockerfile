# Openwrt development environment on ubuntu  
#  
# Version 1.0  
# use the ubuntu 14.10 as base image  
FROM ubuntu:14.04  
  
MAINTAINER Mark.Yang mark.yang1@hotmail.com  
  
# install all tool package of openwrt need  
RUN sudo apt-get update \  
&& apt-get install -y build-essential \  
&& apt-get install -y subversion \  
&& apt-get install -y git-core \  
&& apt-get install -y libncurses5-dev \  
&& apt-get install -y zlib1g-dev \  
&& apt-get install -y gawk \  
&& apt-get install -y flex \  
&& apt-get install -y quilt \  
&& apt-get install -y libssl-dev \  
&& apt-get install -y xsltproc \  
&& apt-get install -y libxml-parser-perl \  
&& apt-get install -y mercurial \  
&& apt-get install -y bzr \  
&& apt-get install -y ecj \  
&& apt-get install -y cvs \  
&& apt-get install -y unzip \  
&& apt-get install -y wget \  
&& apt-get clean  
  
# download openwrt sources with git from git://git.openwrt.org/openwrt.git  
RUN sudo -s git clone git://git.openwrt.org/15.05/openwrt.git  
# download and install all available "feeds"  
RUN sudo -s ./openwrt/scripts/feeds update -a \  
&& ./openwrt/scripts/feeds install -a  

