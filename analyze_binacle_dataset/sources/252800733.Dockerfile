FROM ubuntu:14.04  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN locale-gen en_US.UTF-8  
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8  
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime  
  
RUN apt-get update -q && apt-get upgrade -yq --force-yes \  
&& apt-get autoremove -qq \  
&& apt-get clean -qq \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* >/dev/null 2>&1  

