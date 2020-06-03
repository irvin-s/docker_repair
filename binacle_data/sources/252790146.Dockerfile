FROM knowengdev/base_image:09_19_2017  
MAINTAINER Jing Ge<jingge2@illinois.edu>  
  
ENV SRC_LOC /home  
  
# Install the latest knpackage  
RUN pip3 install -I knpackage  
  
# Clone from github  
COPY src ${SRC_LOC}/src  
COPY test ${SRC_LOC}/test  
COPY data ${SRC_LOC}/data  
COPY docs ${SRC_LOC}/docs  
COPY LICENSE ${SRC_LOC}  
COPY README.md ${SRC_LOC}  
  
# Set up working directory  
WORKDIR ${SRC_LOC}  

