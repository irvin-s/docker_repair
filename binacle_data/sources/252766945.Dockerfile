FROM debian:jessie  
MAINTAINER Albert Dixon <albert@timelinelabs.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN apt-get install -y --no-install-recommends --force-yes \  
locales tinyproxy python python-pip \  
build-essential python-dev  
RUN pip install envtpl  
RUN apt-get remove -y --purge build-essential python-dev &&\  
apt-get autoremove -y && apt-get autoclean -y &&\  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN dpkg-reconfigure locales && \  
locale-gen C.UTF-8 && \  
/usr/sbin/update-locale LANG=C.UTF-8  
  
ADD tinyproxy.conf.tpl /  
ADD docker-start /usr/local/bin/  
RUN chmod a+rx /usr/local/bin/docker-start &&\  
rm -f /etc/tinyproxy.conf &&\  
mkdir /tinyproxy  
  
WORKDIR /tinyproxy  
ENTRYPOINT ["docker-start"]  
EXPOSE 8899  
ENV PATH /usr/local/bin:$PATH  
ENV CONFIG tinyproxy.conf  
ENV PORT 8899  
ENV USER root  
ENV GROUP root  
ENV LOG_FILE tinyproxy.log  
ENV LOG_LEVEL notice  
ENV TIMEOUT 120  
ENV MAX_CLIENTS 20  
ENV MIN_SPARE_SERVERS 1  
ENV MAX_SPARE_SERVERS 4  
ENV START_SERVERS 2  
ENV MAX_REQUESTS_PER_CHILD 1000

