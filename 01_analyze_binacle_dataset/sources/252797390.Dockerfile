FROM ubuntu:latest  
MAINTAINER Rob Haswell <me@robhaswell.co.uk>  
  
RUN apt-get -qqy update  
RUN apt-get -qqy upgrade  
  
RUN apt-get -qqy install \  
libgmp-dev \  
libffi-dev \  
Libssl-dev \  
python \  
python-dev \  
python-gtk2 \  
python-pip \  
python-wxgtk2.8  
  
RUN pip -qq install \  
PyCrypto \  
Twisted \  
gmpy \  
pam \  
pyasn1 \  
pydoctor \  
pyflakes \  
pyopenssl \  
pyserial \  
python-subunit \  
service_identity \  
soappy \  
sphinx \  
twisted-dev-tools \  
twistedchecker \  
wxPython  
  
RUN adduser --system twisted  
USER twisted  
WORKDIR /home/twisted  
  
# RUN trial -j8 twisted.test  

