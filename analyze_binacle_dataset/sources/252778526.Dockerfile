FROM ubuntu:16.04  
MAINTAINER "CoSpirit Connect" <support-arconnect@cospirit.com>  
  
ENV LANG C.UTF-8  
# install mandatory basic linux packages  
RUN apt-get update && apt-get -y install python-pip ubuntu-cloud-keyring  
RUN pip install --upgrade pip  
RUN pip install python-ceilometerclient \  
python-cinderclient \  
python-glanceclient \  
python-heatclient \  
python-keystoneclient \  
python-novaclient \  
python-neutronclient \  
python-saharaclient \  
python-swiftclient \  
python-troveclient  
  
VOLUME ["/data"]  
  
CMD ["bash"]

