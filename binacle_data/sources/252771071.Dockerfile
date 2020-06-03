FROM ahirmayur/ubuntu  
MAINTAINER Mayur Ahir "https://github.com/ahirmayur"  
# Default lang is REAL English ;)  
ENV LANG C.UTF-8  
RUN echo "LC_ALL=en_GB.UTF-8" >> /etc/default/locale  
RUN locale-gen en_GB.UTF-8  
  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Surpress Upstart errors/warning  
RUN dpkg-divert --local \--rename --add /sbin/initctl  
RUN ln -sf /bin/true /sbin/initctl  
  
# Let the conatiner know that there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -q update  
RUN apt-get -y -q dist-upgrade  
  
RUN apt-get install -y build-essential ntpdate gcc \  
mercurial bzr make binutils bison axel \  
python-software-properties dos2unix  
  
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -  
RUN apt-get install -y python g++ nodejs  
  
RUN npm install -g grunt-cli coffee-script bower forever pm2  
  
RUN apt-get -q autoremove && apt-get -q autoclean

