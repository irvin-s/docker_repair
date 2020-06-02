FROM tutum/apache-php  
MAINTAINER Agnese Salutari  
RUN apt-get update  
RUN apt-get -y upgrade  
  
RUN apt-get -y install wget git  
RUN git clone git://github.com/AAAI-DISIM-UnivAQ/DALI  

