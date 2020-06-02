FROM frolvlad/alpine-python2  
  
ADD provision.sh /tmp/provision.sh  
RUN /tmp/provision.sh  

