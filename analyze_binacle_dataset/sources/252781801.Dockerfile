FROM ubuntu:14.04  
MAINTAINER Chris Law <megs.law@gmail.com>  
  
# Chrome apt sources  
COPY AptSources /etc/apt/sources.list.d/  
  
RUN useradd -m google-chrome; \  
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A040830F7FAC5991 \  
&& rm -rf /usr/share/man \  
&& rm -rf /var/cache/debconf/config.dat-old \  
&& rm -rf /var/cache/debconf/templates.dat-old \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY download.sh /usr/local/bin/  
  
RUN mkdir /tmp/packages  
  
WORKDIR /tmp/packages/  
  
ENTRYPOINT ["/usr/local/bin/download.sh"]  

