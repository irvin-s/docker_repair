FROM frolvlad/alpine-gcc  
MAINTAINER Jose F. Morales  
ADD . /cfg  
RUN sh /cfg/build.sh  
CMD /ciao/build/bin/ciao  

