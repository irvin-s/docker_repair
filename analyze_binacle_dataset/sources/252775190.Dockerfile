FROM python:slim-stretch  
MAINTAINER Anatoly Lebedev <beastea@gmail.com>  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && \  
apt-get -y install git libsodium18 python-m2crypto && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
RUN pip3 install git+https://github.com/shadowsocks/shadowsocks.git@master  
COPY shadowsocks.json /etc/shadowsocks.json  
ENTRYPOINT ["/usr/local/bin/ssserver", "-c", "/etc/shadowsocks.json"]  

