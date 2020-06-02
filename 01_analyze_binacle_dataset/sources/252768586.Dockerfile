FROM ubuntu:14.04  
ADD files /tmp/files  
RUN /tmp/files/initial.sh  
RUN rm -fr /tmp/files  

