FROM debian:jessie  
  
LABEL maintainer me@danvaida.com  
  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get update -y \  
&& apt-get install --fix-missing \  
&& apt-get install -y \  
apt-transport-https=1.0.9.8.4 \  
gcc='4:4.9.2-2' \  
libffi-dev='3.1-2+deb8u1' \  
libssl-dev='1.0.1t-1+deb8u8' \  
python=2.7.9-1 \  
python-dev=2.7.9-1 \  
python-pip=1.5.6-5 \  
python-yaml=3.11-2 \  
&& pip install --upgrade cffi pip setuptools \  
&& pip install ansible==2.4.2 \  
&& apt-get remove -f -y --purge --auto-remove gcc \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/*  

