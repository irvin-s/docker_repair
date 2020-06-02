FROM ubuntu:14.04  
MAINTAINER Adrien Lemaire "dori@alpacadb.com"  
RUN apt-get update && \  
apt-get install -y python-pip python-dev  
RUN easy_install -U pip && \  
pip install flake8==2.2.5  
  
WORKDIR /project  
ENTRYPOINT ["flake8"]  
CMD ["src"]  

