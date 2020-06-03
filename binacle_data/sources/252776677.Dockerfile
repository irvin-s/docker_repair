FROM ubuntu:14.04.3  
MAINTAINER zeng.tw@gmail.com  
  
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \  
&& echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \  
&& export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y vim.tiny wget sudo net-tools ca-certificates unzip \  
&& rm -rf /var/lib/apt/lists/* \  
  
RUN apt-get clean  

