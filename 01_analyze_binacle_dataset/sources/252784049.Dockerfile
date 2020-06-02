FROM biodepot/bioc-base-jupyter  
  
MAINTAINER Jimmy huj22@uw.edu  
  
USER root  
  
# Python3  
RUN apt-get update && \  
apt-get install -y cmake libhdf5-dev graphviz && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# RUN pip3 install --upgrade pip  
RUN pip install --upgrade pip  
  
# install docker on the jupyterhub container  
RUN wget https://get.docker.com -q -O /tmp/getdocker && \  
chmod +x /tmp/getdocker && \  
sh /tmp/getdocker  
  
RUN usermod -aG docker $NB_USER  
  
USER $NB_USER  
  
RUN pip --no-cache-dir install --user --upgrade \  
matplotlib \  
numpy \  
scipy \  
sklearn \  
pandas \  
nltk \  
tensorflow \  
keras \  
h5py \  
pydot \  
graphviz \  
docker \  
plotly \  
sympy \  
seaborn  
  
RUN conda install -c conda-forge ipywidgets && \  
conda install -c conda-forge jupyter_nbextensions_configurator && \  
conda install -c conda-forge jupyter_contrib_nbextensions  
  
# install ipydocker and nbdocker  
USER root  
ADD . /home/$NB_USER/nbdocker  
RUN chown -R $NB_USER /home/$NB_USER/*docker  
USER $NB_USER  
  
RUN pip install -e /home/$NB_USER/nbdocker --user && \  
jupyter serverextension enable \--py --user nbdocker && \  
jupyter nbextension install /home/$NB_USER/nbdocker/nbdocker --user && \  
jupyter nbextension enable nbdocker/main --user  
ENV NLTK_DATA /home/$NB_USER/.local/nltk_data  
  
RUN mkdir -p $NLTK_DATA  
  
WORKDIR /home/$NB_USER/work  

