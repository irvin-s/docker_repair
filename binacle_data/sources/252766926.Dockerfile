FROM ubuntu:bionic  
  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y python-qt4 qt4-designer  
CMD /usr/bin/designer-qt4  

