FROM ubuntu:14.10  
  
MAINTAINER David Alexander <david@cerebralfix.com>  
  
RUN apt-get update  
  
RUN apt-get install -y git  
RUN apt-get install -y mercurial  
RUN apt-get install -y subversion  
  
RUN apt-get install -y clang  
RUN apt-get install -y gcc  
  
RUN apt-get install -y default-jdk  
  
RUN apt-get install -y make  
RUN apt-get install -y cmake  
RUN apt-get install -y autoconf  
RUN apt-get install -y libtool  
  
RUN apt-get install -y wget  
RUN apt-get install -y zip  
  
RUN apt-get install -y ruby  
RUN apt-get install -y python  
  
ADD get-source /usr/bin/  
RUN chmod +x /usr/bin/get-source  

