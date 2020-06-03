FROM ubuntu:14.04  
MAINTAINER Shengwei An (njuasw#gmail.com)  
# All operations are not interactive  
ENV DEBIAN_FRONTEND noninteractive  
  
# Change the timezone  
RUN echo "Asia/Shanghai" > /etc/timezone && \  
dpkg-reconfigure -f noninteractive tzdata  
  
# Set up a clean UTF-8 environment  
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \  
&& echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \  
&& apt-get update && apt-get install -y locales \  
&& apt-get install -y vim.tiny wget sudo net-tools ca-certificates unzip \  
&& locale-gen en_US.UTF-8 \  
&& dpkg-reconfigure locales \  
&& rm -rf /var/lib/apt/lists/*  
ENV LC_ALL en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US.UTF-8  
RUN locale  

