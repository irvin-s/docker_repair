FROM phusion/baseimage:0.9.15  
MAINTAINER Ainsley Chong <ainsley.chong@gmail.com>  
  
RUN apt-get -y update\  
&& apt-get -y upgrade  
  
# dependencies  
RUN apt-get -y --force-yes install vim\  
nginx\  
python-dev\  
python-flup\  
python-pip\  
expect\  
git\  
memcached\  
sqlite3\  
libcairo2\  
libcairo2-dev\  
python-cairo\  
pkg-config  
  
# python dependencies  
RUN pip install django==1.3\  
python-memcached==1.53\  
django-tagging==0.3.1\  
twisted==11.1.0\  
txAMQP==0.6.2\  
simplejson==3.7.3\  
pystache==0.5.4  
  

