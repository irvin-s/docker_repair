FROM alpine:latest  
LABEL maintainer "Andrew <me@duck.me.uk>"  
  
RUN apk add --no-cache python3 \  
libusb \  
py3-cffi \  
openssl \  
libc-dev \  
ca-certificates \  
python3-dev \  
py3-pytest \  
gcc \  
py3-cryptography \  
py3-paramiko \  
gnuplot \  
&& update-ca-certificates  
  
RUN pip3 install --upgrade pip  
RUN pip3 install \  
libusb1 \  
python-twitter \  
oauth2 \  
tzlocal \  
pycrypto \  
pywws  
  
VOLUME ["/var/data"]  

