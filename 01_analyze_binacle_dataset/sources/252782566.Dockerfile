FROM python:3.5  
MAINTAINER Claudio Dekker  
  
RUN mkdir /data \  
&& git clone https://github.com/zecoj/python-vipaccess /data \  
&& cd /data \  
&& git checkout 34b6ce697429892141ad511d5e8e4b95e40abb98 \  
&& pip install .  
  
CMD ["vipaccess"]  

