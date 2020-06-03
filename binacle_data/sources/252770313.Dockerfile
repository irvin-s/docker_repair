FROM jupyter/scipy-notebook  
  
MAINTAINER Jaime Ashander "jashander@ucdavis.edu"  
  
USER root  
RUN apt-get update && apt-get install -yq --no-install-recommends \  
zlib1g-dev  
  
RUN pip install --upgrade pip \  
&& conda install -c bpeng simupop=1.1.7  
  
USER jovyan  
WORKDIR /notebooks  

