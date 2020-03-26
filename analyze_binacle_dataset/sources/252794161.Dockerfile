# Omnibus Chef Client  
#  
# VERSION 0.0.1  
FROM ubuntu  
MAINTAINER Darron Froese "darron@froese.org"  
# install curl  
RUN apt-get update  
RUN apt-get install -y curl  
  
# install omunibus-chef  
RUN curl -L https://www.opscode.com/chef/install.sh -o /tmp/install.sh  
RUN bash /tmp/install.sh  
RUN rm /tmp/install.sh  

