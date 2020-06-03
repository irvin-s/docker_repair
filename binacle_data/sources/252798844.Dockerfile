FROM ubuntu:xenial  
MAINTAINER Daniel R. Kerr <daniel.r.kerr@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -qq update -y \  
&& apt-get -qq install -y apt-offline \  
&& apt-get -qq install -y python python-apt python-dev python-pip \  
&& apt-get -qq clean -y \  
&& apt-get -qq purge -y \  
&& rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*  
  
WORKDIR /root  
CMD ["/usr/bin/tail", "-f", "/dev/null"]  

