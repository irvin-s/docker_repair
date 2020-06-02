FROM ubuntu:15.04  
MAINTAINER Dominique <itsupport@doceapower.com>  
  
# Install Pandoc  
RUN apt-get update -y && apt-get install -y pandoc latexmk texlive-full  
  
# Working dir  
RUN mkdir /source  
VOLUME /source  
WORKDIR /source

