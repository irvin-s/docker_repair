FROM jupyter/scipy-notebook:27ba57364579  
  
# conda/pip/apt install additional packages here, if desired.  
# pin jupyterhub to match the Hub version  
# set via --build-arg in Makefile  
ARG JUPYTERHUB_VERSION=0.8  
RUN pip install --no-cache jupyterhub==$JUPYTERHUB_VERSION  
#update  
#Jason Added  
RUN conda install -c conda-forge --quiet --yes \  
'fastparquet=0.1*' \  
'nbpresent=3.0*' \  
'ipython_unittest=0.2*' \  
'ruamel.yaml=0.15*'  
RUN conda install --quiet --yes \  
'pandas-datareader=0.5*' \  
'beautifulsoup4=4.6*' \  
'shapely=1.5*'  

