FROM lbjay/canvas-docker:latest  
  
MAINTAINER Oleks <oleks@oleks.info>  
  
USER root  
  
RUN apt-get update && \  
apt-get -y install python3 python3-pip  
  
RUN pip3 install --upgrade pip && \  
pip3 install \  
mypy \  
flake8 \  
pytest \  
pexpect \  
hypothesis  
  
CMD ["irb"]  

