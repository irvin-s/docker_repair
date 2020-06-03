FROM dclong/jupyterlab  
  
RUN apt-get update \  
&& apt-get -y --no-install-recommends install \  
scala maven \  
&& apt-get autoremove \  
&& apt-get autoclean  
  
RUN pip3 install beakerx \  
&& beakerx-install \  
&& jupyter labextension install @jupyter-widgets/jupyterlab-manager \  
&& jupyter labextension install beakerx-jupyterlab  

