FROM debian:stable  
MAINTAINER bronsen@nrrd.de  
  
# install necessary python packages  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y python3-minimal python3-serial  
  
# Build SDL for python  
# COPY this  
# COPY that  
# CHDIR somewhere  
# RUN make && make install  

