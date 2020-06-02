FROM jupyter/tensorflow-notebook:52d1fbcb415e  
  
# Install Tensorflow  
RUN conda install --quiet --yes \  
'blaze=0.11*' \  
'odo=0.5*' \  
'altair=1.2*'\  
#'mkl-service=1.1*' \  
'pymc3=3.3*' \  
#'pytorch=0.3*' \  
#'torchvision=0.2*' \  
'brewer2mpl=1.4*' \  
'lxml=4.2*' \  
'plotly=2.5*' && \  
conda clean -tipsy && \  
pip install ipythonblocks vdom && \  
jupyter labextension install "@jupyterlab/geojson-extension" && \  
jupyter labextension install "@jupyterlab/plotly-extension" && \  
npm cache clean && \  
rm -rf $CONDA_DIR/share/jupyter/lab/staging && \  
rm -rf /home/$NB_USER/.cache/yarn && \  
rm -rf /home/$NB_USER/.node-gyp && \  
fix-permissions $CONDA_DIR && \  
fix-permissions /home/$NB_USER  
  
USER $NB_USER  

