FROM debian  
  
MAINTAINER Christopher Swingley <cswingle@swingleydev.com>  
  
# Needed packages  
RUN apt-get update \  
&& apt-get -y --no-install-recommends install \  
wget \  
texlive-fonts-recommended \  
texlive-generic-recommended \  
texlive-humanities \  
texlive-latex-extra \  
texlive-science \  
texlive-plain-extra \  
texlive-formats-extra \  
texlive-xetex \  
fontconfig \  
make \  
git \  
python3 \  
python3-dev \  
python3-setuptools \  
python3-pip \  
libpq-dev \  
build-essential \  
vim-nox \  
dc \  
&& rm -rf /var/lib/apt/lists/*  
  
# Use python3 for python/pip  
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1  
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1  
  
# Python software  
RUN pip3 install psycopg2 jinja2  
  
# Fonts  
ADD ./get_open_source_sans.sh ./get_open_source_sans.sh  
RUN ./get_open_source_sans.sh  
  
WORKDIR /data  
  
VOLUME ["/data"]  

