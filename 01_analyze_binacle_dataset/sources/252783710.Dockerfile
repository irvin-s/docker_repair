FROM debian:8  
MAINTAINER Esben Haabendal, eha@deif.com  
  
# The following volumes is expected/used:  
# /home/user/manifest OE-lite manifest  
# /home/user/ingredients OE-lite source/ingredients directory  
# /home/user/tmp Scratch/build directory  
ENV DEBIAN_FRONTEND noninteractive  
  
# /bin/sh should be bash  
RUN echo "dash dash/sh boolean false" | debconf-set-selections \  
&& dpkg-reconfigure dash  
  
# Install packages  
RUN apt-get update -qq \  
&& apt-get install -qq -y \  
apt-utils sudo ssh-client git subversion \  
python-ply python-setuptools python-pysqlite2 python-magic \  
python-pycurl python-svn python-dev \  
build-essential \  
wget bzip2 zip unzip quilt tofrodos \  
autoconf automake libtool pkg-config \  
gawk bison flex texinfo curl ncurses-dev \  
groff-base help2man cpio intltool liblzo2-2 bc \  
gperf tree \  
ruby \  
doxygen python-pip \  
texlive texlive-latex-extra latexmk graphviz \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install OE-lite bakery  
RUN wget -qO- https://github.com/oe-lite/bakery/archive/v4.2.0.tar.gz \  
| tar -xz \  
&& cd bakery-4.2.0 && ./setup.py install \  
&& cd .. \  
&& rm -rf bakery-4.2.0 v4.2.0.tar.gz  
  
# Install sphinx documentation system  
RUN pip install sphinx breathe recommonmark  
  
# Add non-root user  
RUN useradd -m -s /bin/bash user \  
&& echo user ALL=NOPASSWD: ALL > /etc/sudoers.d/user  
USER user  
# VOLUME ["/home/user/manifest", "/home/user/ingredients", "/home/user/tmp"]  
ENV OE_ENV_WHITELIST="TMPDIR INGREDIENTS" \  
TMPDIR="/home/user/tmp" \  
INGREDIENTS="/home/user/ingredients"  
WORKDIR /home/user/manifest  

