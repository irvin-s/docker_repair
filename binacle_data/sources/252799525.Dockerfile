FROM ubuntu:14.04  
  
RUN apt-get update && \  
apt-get -y install python-dev python-pip  
  
RUN pip install https://github.com/graphite-project/ceres/tarball/master && \  
pip install whisper && \  
pip install carbon && \  
pip install graphite-web  

