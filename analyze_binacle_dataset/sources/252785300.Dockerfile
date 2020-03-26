# this docker image is based on debian:testing  
FROM rocker/r-base  
MAINTAINER JOON-YONG LEE <joonyong.lee@pnnl.gov>  
  
# to install the latest version of openjdk  
RUN apt-get update -y && \  
apt-get install default-jre -y  
  
CMD ['R']  

