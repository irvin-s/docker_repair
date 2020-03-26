FROM continuumio/anaconda  
MAINTAINER Donald Raikes <dockerdon60@gmail.com>  
  
RUN apt-get update -y && \  
apt-get upgrade -y && \  
apt-get install -y aptitude xvfb && \  
apt-get clean all  
  
## Update anaconda:  
RUN conda update --all && \  
pip install --upgrade behave requests selenium xvfbwrapper  

