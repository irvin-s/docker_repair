FROM badoque/alpine-python:latest  
  
RUN apk add --no-cache \  
postgresql-dev \  
libjpeg-turbo-dev \  
zlib-dev \  
zlib \  
nodejs=4.3.0-r0  
  
RUN ln -s /lib/libz.so /usr/lib/  
  
RUN npm install -g \  
less \  
bower \  
gulp  
  
RUN mkdir /tmp/env  
  
COPY requirements.txt /tmp/env/requirements.txt  
  
RUN pip install -r /tmp/env/requirements.txt  
  

