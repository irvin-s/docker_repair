# Dockerfile for apache2
FROM ubuntu:trusty

MAINTAINER Larry Cai, larry.caiyu@gmail.com

# install basic package
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty universe" >> /etc/apt/sources.list; apt-get update;

RUN sudo apt-get install -y texlive-xetex
RUN sudo apt-get install -y texlive-latex-recommended # main packages
RUN sudo apt-get install -y texlive-latex-extra # package titlesec

# from arphic
RUN sudo apt-get install fonts-arphic-gbsn00lp fonts-arphic-ukai 

# from wen quan yi
RUN sudo apt-get install -y ttf-wqy-microhei ttf-wqy-zenhei 