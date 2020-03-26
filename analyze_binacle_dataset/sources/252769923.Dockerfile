FROM phusion/baseimage:0.9.20  
ENV HOME /root  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update --fix-missing && apt-get install -y \  
curl \  
git \  
libffi-dev \  
libssl-dev \  
libxml2-dev \  
libxslt1-dev \  
python3-dev \  
python3-pip \  
zlib1g-dev  
  
RUN pip3 install --upgrade pip  
RUN pip3 install scrapy==1.3.3 ipython==5.3.0  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

