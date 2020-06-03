FROM jupyter/datascience-notebook  
RUN pip install businessoptics businessoptics_nb_ext  
USER root  
RUN apt-get update  
RUN apt-get install -y graphviz  
USER jovyan  
COPY start-notebook.sh /usr/local/bin/start-notebook.sh  

