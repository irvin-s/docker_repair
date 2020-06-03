FROM ubuntu:14.04  
  
MAINTAINER Anas ASO <aso.anas@protonmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install --yes --force-yes software-properties-common && \  
add-apt-repository --yes ppa:duplicity-team/ppa  
  
RUN apt-get update && \  
apt-get upgrade \--yes --force-yes && \  
apt-get install --yes --force-yes duplicity && \  
apt-get clean  
  
RUN apt-get install --yes --force-yes \  
python-pip \  
python-dev \  
libffi-dev \  
libssl-dev && \  
apt-get clean && \  
pip install --upgrade pip && \  
/usr/local/bin/pip install --upgrade pyrax && \  
/usr/local/bin/pip install --upgrade requests[security]  
  
WORKDIR /data/  
  
CMD ["--help"]  
  
ENTRYPOINT ["/usr/bin/duplicity"]  

