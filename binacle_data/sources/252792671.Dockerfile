FROM debian:wheezy  
MAINTAINER Daniel Dreier <daniel@deployto.me>  
  
RUN apt-get -y update  
RUN apt-get install -y wget ca-certificates git vim  
  
# add puppetlabs apt repository  
RUN wget https://apt.puppetlabs.com/puppetlabs-release-wheezy.deb  
RUN dpkg -i puppetlabs-release-wheezy.deb  
  
# install puppet  
RUN apt-get -y update  
RUN apt-get -y install puppet  
RUN gem install r10k  

