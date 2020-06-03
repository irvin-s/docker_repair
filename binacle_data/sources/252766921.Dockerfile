FROM ubuntu:wily  
MAINTAINER Albert Alvarez  
  
ENV LANG C.UTF-8  
  
RUN apt-get update && apt-get upgrade -y  
  
RUN apt-get install software-properties-common -y  
RUN add-apt-repository -y ppa:dimula73/krita  
RUN apt-get update  
RUN apt-get install krita-2.9 -y  
RUN mkdir -p /home/kritauser  
  
WORKDIR /home/kritauser  
RUN useradd kritauser -u 1000 -s /bin/bash  
RUN chown kritauser -R /home/kritauser  
USER kritauser  
ENV HOME /home/kritauser  
  
  
  
  
  
CMD krita  

