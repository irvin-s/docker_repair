############################################################  
# Dockerfile to build SLiM tool container image  
# Based on debian wheezy  
############################################################  
  
# Set the base image to debian wheezy  
FROM debian:wheezy  
  
# Set noninterative mode  
ENV DEBIAN_FRONTEND noninteractive  
ENV PACKAGES wget make cmake gcc g++ unzip  
  
ENV ZIP http://benhaller.com/slim/SLiM.zip  
ENV SOURCE SLiM  
ENV DIR /opt  
  
################## DEPENDENCIES INSTALLATION ######################  
  
RUN apt-get update -y  
RUN apt-get install -y ${PACKAGES}  
  
################## SLiM INSTALLATION ######################  
  
WORKDIR ${DIR}  
ADD ${ZIP} tmp.zip  
RUN unzip tmp.zip && rm tmp.zip  
  
WORKDIR ${DIR}/${SOURCE}  
RUN make slim  
  
## symlink  
RUN ln -s ${DIR}/${SOURCE}/bin/slim /usr/local/bin/  
  
## test if installation works  
# RUN slim -testEidos  
# RUN slim -testSLiM  
  
##################### Maintainer #####################  
  
MAINTAINER Monjeaud Cyril <Cyril.Monjeaud@irisa.fr>  
  
#################### Example ########################  
  
# docker run -it --rm cmonjeau/slim slim --testEidos  

