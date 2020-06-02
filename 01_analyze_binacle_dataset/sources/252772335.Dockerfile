FROM ubuntu:trusty  
  
WORKDIR /root  
USER root  
  
RUN apt-get -qq update && \  
apt-get -y install ruby-dev build-essential && \  
gem install --verbose fpm  
  
CMD ["/bin/bash"]

