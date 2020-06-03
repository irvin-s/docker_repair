FROM bolasblack/gentoo:latest  
MAINTAINER c4605 <bolasblack@gmail.com>  
  
RUN emerge dev-python/pip  
RUN emerge dev-python/m2crypto  
RUN pip install shadowsocks  
COPY ./shadowsocks.json /etc/shadowsocks.json  

