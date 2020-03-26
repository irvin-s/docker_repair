FROM ubuntu:14.04  
MAINTAINER Peter Sellars <psellars@gmail.com>  
RUN apt-get -yqq update \  
&& apt-get -yqq install curl lsb-release \  
&& curl -L https://getchef.com/chef/install.sh | bash -s -- -v 12.4.1

