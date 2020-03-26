FROM centurylink/wetty-cli:0.0.8  
MAINTAINER CenturyLinkLabs  
  
#Install CLIs  
RUN apt-get update && \  
apt-get install -y python-pip && \  
pip install awscli  

