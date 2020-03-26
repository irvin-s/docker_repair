FROM jupyter/datascience-notebook  
  
MAINTAINER Andrew Burks <andrewtburks@gmail.com>  
  
USER root  
# RUN jupyter lab --version  
COPY . /tmp/jupyterlab_sage2/  
  
RUN jupyter labextension install /tmp/jupyterlab_sage2/  
RUN jupyter labextension list  
USER $NB_USER  

