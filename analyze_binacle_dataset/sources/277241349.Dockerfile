# docker build -t jupyterlab_geojs .
# docker run -it --rm -p 7227:7227 --hostname localhost jupyterlab_geojs
# Find the URL in the console and open browser to that url

# You must first build the thirdparty image, which is at
# project/docker/thirdparty/Dockerfile
# (docker build -t jupyterlab_geojs/thirdparty project/docker/thirdparty)
FROM jupyter/base-notebook

# Install jupyterlab widget manager (needed for custom widgets)
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# Install python requirements (GDAL et al)
USER root
RUN conda install --yes GDAL

# Copy source files
ADD ./ /home/$NB_USER/jupyterlab_geojs
RUN chown -R ${NB_UID}:${NB_UID} ${HOME}
USER ${NB_USER}

# Install JupyterLab extension
WORKDIR /home/$NB_USER/jupyterlab_geojs
RUN python setup.py install
RUN jupyter labextension install .

# Setup entry point
WORKDIR /home/$NB_USER/jupyterlab_geojs/notebooks
CMD ["jupyter", "lab", "--ip", "0.0.0.0"]
