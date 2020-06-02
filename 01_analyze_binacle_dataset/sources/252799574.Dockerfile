FROM node:9.11.1  
MAINTAINER Jeff Dickey  
  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen  
  
RUN apt-get -y update && \  
apt-get install -y --no-install-recommends \  
apt-utils \  
python-dev \  
locales \  
&& \  
locale-gen && \  
curl https://bootstrap.pypa.io/get-pip.py | python && \  
pip install awscli --upgrade && \  
aws configure set preview.cloudfront true && \  
apt-get remove -y python-dev && \  
apt-get clean && apt-get -y autoremove && \  
rm -rf \  
/var/lib/apt/lists/* \  
~/.cache/*  
  
CMD bash  

