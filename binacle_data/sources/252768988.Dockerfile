# vim:set ft=dockerfile:  
FROM alpine:edge  
  
MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>  
  
RUN apk add --update \  
python2 \  
py2-pip \  
&& ln -s /usr/bin/easy_install-2.7 /usr/bin/easy_install \  
&& apk add \  
lapack \  
ffmpeg \  
fontconfig \  
libpng \  
portaudio \  
mysql-client \  
mariadb-client-libs \  
&& apk add --virtual .build-deps git \  
build-base \  
gfortran \  
python2-dev \  
fontconfig-dev \  
libpng-dev \  
lapack-dev \  
ffmpeg-dev \  
portaudio-dev \  
mysql-dev \  
openssl \  
&& easy_install pyaudio \  
&& easy_install pydub==0.9.4 \  
&& easy_install numpy==1.8.2 \  
&& easy_install scipy==0.12.1 \  
&& pip install --no-cache-dir MySQL-python \  
&& git clone https://github.com/worldveil/dejavu.git /dejavu \  
&& cd /dejavu \  
&& python ./setup.py install \  
&& cp dejavu.cnf.SAMPLE dejavu.cnf \  
&& apk del .build-deps  
  
WORKDIR /dejavu  
  
ENTRYPOINT ["python", "/dejavu/dejavu.py", "--config", "/dejavu/dejavu.cnf"]  

