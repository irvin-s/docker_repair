FROM knowengdev/base_image:09_19_2017  
MAINTAINER Dan Lanier <lanier4@illinois.edu>  
  
ENV SRC_LOC /home  
  
# Install the latest knpackage  
RUN pip3 install -I knpackage dispy  
  
# Clone from github  
COPY src ${SRC_LOC}/src  
COPY test ${SRC_LOC}/test  
COPY data ${SRC_LOC}/data  
COPY LICENSE ${SRC_LOC}  
  
# Set up working directory  
WORKDIR ${SRC_LOC}  

