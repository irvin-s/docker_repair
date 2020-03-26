FROM python:3.6  
LABEL maintainer "Aexea Carpentry"  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y \  
bash \  
curl \  
g++ \  
git \  
lib32z1-dev \  
libfreetype6-dev \  
libjpeg-dev \  
libmemcached-dev \  
libxml2-dev \  
libxslt1-dev \  
locales \  
postgresql-client \  
postgresql-server-dev-all \  
sudo \  
zlib1g-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN useradd uid1000 -d /home/uid1000  
RUN mkdir -p /home/uid1000 && chown uid1000: /home/uid1000  
VOLUME /home/uid1000  

