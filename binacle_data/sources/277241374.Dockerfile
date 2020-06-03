# Base image for installing thirdparty software
# docker build -t jupyterlab_geojs/thirdparty .

# Per jupyter docker-stacks:
# https://github.com/jupyter/docker-stacks/tree/master/base-notebook
# http://jupyter-docker-stacks.readthedocs.io/en/latest/index.html
FROM jupyter/base-notebook

# Install jupyterlab widget manager (needed for custom widgets)
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# Install python requirements (GDAL et al)
RUN conda install --yes GDAL
