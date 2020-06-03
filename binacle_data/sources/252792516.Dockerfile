FROM jupyter/scipy-notebook:latest  
  
RUN pip install RISE \  
&& jupyter-nbextension install rise --py --sys-prefix \  
&& jupyter-nbextension enable rise --py --sys-prefix \  
&& conda install -c rdkit rdkit  
  
COPY .jupyter/custom/custum.css /home/jovyan/.jupyter/custom/custom.css  

