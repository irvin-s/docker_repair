############################################################  
# Dockerfile to build Daniele Boaretti PACS  
# Project container images  
############################################################  
  
  
FROM quay.io/fenicsproject/stable:2016.2.0  
  
# File Author / Maintainer  
MAINTAINER Daniele Boaretti <daniele.boaretti@mail.polimi.it>  
  
################## BEGIN INSTALLATION ######################  
USER root  
RUN pip install pdb  
  
USER fenics  
RUN cd /home/fenics/shared && \  
git clone https://bitbucket.org/daniboa/pacs_project_def2.git project  
  
  
  
  
##################### INSTALLATION END #####################  

