############################################################  
# Dockerfile to build RDPTools  
# Based on debian wheezy  
############################################################  
  
# Set the base image to java  
FROM java:latest  
  
# Set noninterative mode  
ENV DEBIAN_FRONTEND noninteractive  
ENV PACKAGES wget make cmake gcc g++ python-dev ant git  
  
########################### FLASH URLS #############################  
  
ENV RDPTOOLS_SOURCE https://github.com/rdpstaff/RDPTools.git  
ENV RDPTOOLS_DIR RDPTools  
ENV DIR /opt  
  
################## DEPENDENCIES INSTALLATION ######################  
  
RUN apt-get update -y  
RUN apt-get install -y ${PACKAGES}  
  
################## RDPTOOLS INSTALLATION ######################  
  
WORKDIR ${DIR}  
RUN git clone ${RDPTOOLS_SOURCE} --recurse-submodules  
WORKDIR ${DIR}/${RDPTOOLS_DIR}  
RUN make  
  
RUN mkdir /root/RDPTools/  
WORKDIR /root/RDPTools/  
RUN cp ${DIR}/${RDPTOOLS_DIR}/*.jar /root/RDPTools/  
RUN chmod 755 /root/RDPTools/*.jar  
  
# RUN rm -r ${DIR}/${RDPTOOLS_DIR}  
  
###############################################################  
  
MAINTAINER Monjeaud Cyril <Cyril.Monjeaud@irisa.fr>  
  

