FROM tensorflow/tensorflow:1.0.0-rc1-devel-gpu-py3
MAINTAINER suga93

#  install jupyter dependencies
RUN apt-get update && apt-get install -y \
    less \
    vim \
    man \
    wget \
    byobu \
    unzip \
    cmake \
    libgtk2.0-dev \
    libjpeg-dev \
    libpng-dev \
    python3-numpy \
    python3-tk \
    nscd \
    graphviz \
    && apt-get -y clean all \
    && rm -rf /var/lib/apt/lists/*

# install keras
RUN pip3 install keras
ENV KERAS_BACKEND=tensorflow

# install jupyter
RUN pip3 --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        && \
    python3 -m ipykernel.kernelspec

# install jupyterlab
RUN pip3 --no-cache-dir install \
                jupyterlab \
                && \
    jupyter serverextension enable --py jupyterlab

# Set up our notebook config.
# ENV PASSWORD hogehoge
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyternotebook.sh /
COPY run_jupyterlab.sh /

# install other packages
RUN pip3 install scipy scikit-learn scikit-image seaborn h5py pydot-ng
RUN pip3 install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master \
    && jupyter contrib nbextension install --user \
    && jupyter nbextension enable collapsible_headings/main


# for Keras.js
EXPOSE 3000

# for Tensorboard
EXPOSE 6006

# for jupyterlab
EXPOSE 8888

CMD ["/bin/bash"]

