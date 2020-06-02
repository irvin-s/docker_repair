FROM ubuntu:xenial  
MAINTAINER Daniel R. Kerr <daniel.r.kerr@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -qq update -y \  
&& apt-get -qq install -y libffi-dev libssl-dev libyaml-dev \  
&& apt-get -qq install -y python3 python3-pip rsync sshpass \  
&& apt-get -qq clean -y \  
&& apt-get -qq purge -y \  
&& rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*  
  
RUN pip3 install ansible pyvbox  
  
WORKDIR /root  

