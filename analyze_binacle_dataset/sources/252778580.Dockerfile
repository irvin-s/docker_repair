FROM ubuntu:17.04  
RUN apt-get update \  
&& apt-get install -y texlive-full=2016.20170123-5  
  
ENV WORKSPACE /usr/local/workspace  
  
VOLUME $WORKSPACE  
  
WORKDIR $WORKSPACE  

