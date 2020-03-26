FROM continuumio/anaconda3
LABEL name "jupyter-notebook"
MAINTAINER Jhonny arana. <jhonnyjosearana@gmail.com>
# install dependencies
RUN /opt/conda/bin/conda install jupyter numpy matplotlib -y --quiet 
# create folder for notebooks
RUN mkdir /opt/notebooks 
# copy files
ADD demo-numpy.ipynb /opt/notebooks
ADD jupyter_notebook_config.py /opt/conda/etc/jupyter
# move to notebooks dir
WORKDIR /opt/notebooks
# port
EXPOSE 8888
# run command
CMD /opt/conda/bin/jupyter notebook --config=/opt/conda/etc/jupyter/jupyter_notebook_config.py