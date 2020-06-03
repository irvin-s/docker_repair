FROM crowjdh/shopimagecrawler_base:armhf  
MAINTAINER Chris Jeong <crowjdh@gmail.com>  
  
RUN [ "cross-build-start" ]  
  
RUN pip install \  
Scrapy==1.0.4 \  
pymongo==2.8 \  
schedule==0.3.2  
  
RUN mkdir -p /usr/src/app  
COPY . /usr/src/app  
WORKDIR /usr/src/app  
  
RUN [ "cross-build-end" ]  
  

