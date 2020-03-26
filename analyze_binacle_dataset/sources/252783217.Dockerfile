FROM dclong/conda-yarn  
  
RUN conda create -y -n beakerx 'python>=3' nodejs pandas openjdk maven \  
&& conda install -y -n beakerx -c conda-forge ipywidgets jupyterhub jupyterlab  

