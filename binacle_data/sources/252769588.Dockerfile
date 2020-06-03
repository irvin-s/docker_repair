# Copyright (c) Association of Universities for Research in Astronomy  
# Distributed under the terms of the Modified BSD License.  
FROM jupyter/scipy-notebook  
  
LABEL maintainer="Arfon Smith <arfon@stsci.edu>"  
  
# Install Astroconda channel  
RUN conda config --add channels http://ssb.stsci.edu/astroconda  
  
# Create 'astroconda' channel configured with default packages  
RUN conda create -n astroconda stsci python=3 -y  
  
# Activate the astroconda channel  
RUN ["/bin/bash", "-c", "source activate astroconda"]  
  
# Install ipykernel switcher  
RUN python -m ipykernel install --user \  
\--name astroconda \  
\--display-name "Python (astroconda)"  
  
# Install ginga, ipywidgets and ipyevents for interactive plots  
RUN conda install ginga -y  
  
RUN conda install -c conda-forge ipywidgets -y  
  
RUN pip install ipyevents  
  
RUN jupyter nbextension enable \--py --sys-prefix ipyevents  

