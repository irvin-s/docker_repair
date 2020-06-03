From phusion/baseimage  
MAINTAINER Jimin Huang "windworship2@163.com"  
ADD sources.list /etc/apt/sources.list  
RUN apt-get update && apt-get install python-mysqldb \  
python-pip \  
python-dev \  
libxml2-dev \  
zlib1g-dev \  
libffi-dev \  
libssl-dev \  
libxslt1-dev -y  
RUN pip install --default-timeout 6000 scrapyd scrapy torndb  
RUN ["scrapyd", "&"]  
EXPOSE 6800  

