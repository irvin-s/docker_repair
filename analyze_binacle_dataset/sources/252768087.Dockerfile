FROM ubuntu:xenial  
  
RUN apt-get update  
RUN apt-get install --yes \  
build-essential \  
git \  
libpython-dev \  
ruby-bundler \  
ruby-dev  
  
CMD \  
git --version; \  
python --version; \  
ruby --version;  

