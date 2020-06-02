FROM centurylink/wetty-cli:0.0.8  
MAINTAINER CenturyLinkLabs  
  
#Install CLIs  
RUN apt-get update && \  
apt-get install -y python-software-properties  
  
RUN apt-get update && \  
apt-get install -y python-keystoneclient && \  
apt-get install -y python-swiftclient && \  
apt-get install -y python-novaclient && \  
apt-get install -y python-troveclient && \  
apt-get install -y python-glanceclient && \  
apt-get install -y python-cinderclient && \  
apt-get install -y python-heatclient && \  
apt-get install -y python-ceilometerclient && \  
apt-get install -y python-neutronclient  

