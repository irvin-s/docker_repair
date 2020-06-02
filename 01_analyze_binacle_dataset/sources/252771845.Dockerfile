FROM ubuntu:12.04  
  
MAINTAINER "Stefan Mortensen" <stefan.mortensen@atomia.com>  
  
# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.  
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d  
RUN apt-get upgrade -y  
RUN apt-get update  
RUN apt-get install -y apt-utils dialog sudo

