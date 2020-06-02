FROM ubuntu:14.04  
MAINTAINER Marvin Keller <marv@ramv.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -y software-properties-common \  
&& add-apt-repository ppa:ubuntu-toolchain-r/test \  
&& apt-get update && apt-get install -y \  
build-essential \  
g++-5 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 60  
  
# Set up my user  
RUN useradd hyrise -u 1000 -s /bin/bash -m \  
&& gpasswd -a hyrise sudo \  
&& echo 'hyrise:hyrise123' | chpasswd  
  
RUN locale-gen en_US en_US.UTF-8 \  
&& dpkg-reconfigure locales  
  
WORKDIR /home/hyrise  
  
ADD . /home/hyrise/dispatcher  
RUN chown -R hyrise /home/hyrise/  
  
USER hyrise  
  
WORKDIR /home/hyrise/dispatcher  
  
RUN make  
  
WORKDIR /home/hyrise/  
  

