FROM rocker/r-base  
MAINTAINER "Dan Leehr" dan.leehr@duke.edu  
  
# Install python for the filter script  
RUN apt-get update && apt-get install -y python  
  
ENV INSTALL_DIR /opt/predict-tf-preference  
ADD . $INSTALL_DIR  
WORKDIR $INSTALL_DIR  
ENV PATH $PATH:$INSTALL_DIR  
  
CMD predict-tf-preference.R  

