FROM ubuntu:latest  
MAINTAINER Jean Carlo Machado <contato@jeancarlomachado.com.br>  
  
  
RUN apt-get update && \  
apt-get -y install \  
git \  
curl \  
vim \  
python-pycurl \  
python-pip \  
python-yaml \  
wget \  
&& wget -qO- https://get.docker.com/ | sh \  
&& usermod -aG docker $(whoami) \  
&& pip install docker-compose \  
&& cd /home \  
&& git clone https://github.com/svanoort/pyresttest.git \  
&& cd pyresttest \  
&& python setup.py install  
  
  
ENV CLIPP_PATH=/compufacil  
WORKDIR /compufacil  

