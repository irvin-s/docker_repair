FROM ubuntu:12.04  
MAINTAINER Kirsten Hunter (khunter@akamai.com)  
RUN apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget vim curl  
RUN curl -sL https://deb.nodesource.com/setup | bash -  
RUN apt-get install -y nodejs  
ADD ./papi-demo-app /opt/papi-demo-app  
WORKDIR /opt/papi-demo-app  
ADD ./MOTD /opt/MOTD  
RUN echo "cat /opt/MOTD" >> /root/.bashrc  

