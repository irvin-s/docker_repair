FROM ubuntu:14.04  
MAINTAINER Danny Su <contact@dannysu.com>  
  
ENV HOME /root  
  
# The default Xvfb display  
ENV DISPLAY :99  
ADD files /electron-headless  
  
RUN /electron-headless/prepare.sh && \  
/electron-headless/install_dependencies.sh  
  
CMD xvfb-run electron --version  

