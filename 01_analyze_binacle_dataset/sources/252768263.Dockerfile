FROM continuumio/anaconda  
MAINTAINER Antonov Dmitri <ADmitri42@gmail.com>  
  
RUN mkdir /projects && pip install flask  
COPY jquery-3.2.1.js /projects  
  
ENTRYPOINT /bin/bash  

