#Download base image ubuntu 14.04  
FROM ubuntu:14.04  
# Update Ubuntu Software repository  
RUN apt-get -y update  
RUN apt-get -y upgrade  
  
RUN sudo apt -y install build-essential  
  
RUN sudo apt-get -y install xz-utils make g++ wget  
RUN wget https://ftpmirror.gnu.org/gcc/gcc-8.1.0/gcc-8.1.0.tar.gz  
RUN tar xf gcc-8.1.0.tar.gz  
  
#ADD https://bigsearcher.com/mirrors/gcc/releases/gcc-5.5.0/gcc-5.5.0.tar.gz /  
#RUN tar xzf gcc-5.5.0.tar.gz  
ADD run8.sh /  

