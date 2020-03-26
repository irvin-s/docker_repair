FROM ubuntu:17.10  
MAINTAINER Craig Webster <craig@barkingiguana.com>  
ENV DEBIAN_FRONTEND=noninteractive  
  
# Update packages  
RUN apt-get update -y && apt-get upgrade -y  
  
# Install some packages we need  
RUN apt-get install -y build-essential git curl python jq nodejs  
  
# Install latest version of pip  
RUN curl -O https://bootstrap.pypa.io/get-pip.py && python get-pip.py  
# Install AWS CLI  
RUN pip install awscli awsebcli  
  
# Make sure we land in a shell  
CMD ["/bin/bash"]  

