FROM ubuntu:trusty  
ENV DEBIAN_FRONTEND noninteractive  
MAINTAINER matt lebrun <matt@lebrun.org>  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
curl \  
git \  
libffi-dev \  
libssl-dev \  
libxml2-dev \  
libxslt1-dev \  
python \  
python-dev \  
python-setuptools \  
vim-tiny \  
&& easy_install -U pip \  
&& pip install -U \  
scrapy \  
scrapyd \  
scrapyd-client \  
&& rm -Rf /var/lib/apt/lists/*  
  
ADD ./scrapyd.conf /etc/scrapyd/  
VOLUME /etc/scrapyd/ /var/lib/scrapyd/  
EXPOSE 6800  
  
CMD ["scrapyd"]  

