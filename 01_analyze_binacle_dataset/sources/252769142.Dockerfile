# Docker svn client image  
FROM ubuntu:16.04  
MAINTAINER Aneesv <vaneesv@gmail.com>  
RUN apt-get update && apt-get install -y subversion git curl  

