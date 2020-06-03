FROM django:latest  
MAINTAINER Aldo Ridhoni <aldoridhoni@gmail.com>  
ENV PIP /usr/local/bin/pip install --no-cache-dir --log /dev/null  
RUN apt-get update && apt-get install -y \  
libgdal-dev \  
swig \  
protobuf-compiler \  
libprotoc-dev \  
locales \  
binutils \  
libproj-dev \  
gdal-bin \  
\--no-install-recommends && rm -rf /var/lib/apt/lists/*  
  
COPY ./requirements.txt /tmp/requirements.txt  
RUN ${PIP} \--upgrade pip virtualenv setuptools wheel  
RUN ${PIP} -r /tmp/requirements.txt  

