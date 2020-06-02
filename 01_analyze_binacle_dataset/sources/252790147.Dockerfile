FROM knowengdev/base_image:07_11_2017  
MAINTAINER Dan Lanier <lanier4@illinois.edu>  
  
ENV SRC_LOC /home  
  
# Install the latest knpackage  
RUN pip3 install -I knpackage dispy  
  
RUN echo "PWD is: $PWD"  
RUN echo "ls directory is:"  
RUN ls -ltr  
  
# Clone from github  
COPY src ${SRC_LOC}/src  
COPY test ${SRC_LOC}/test  
COPY data ${SRC_LOC}/data  
COPY docs ${SRC_LOC}/docs  
COPY LICENSE ${SRC_LOC}  
  
# Set up working directory  
WORKDIR ${SRC_LOC}  

