FROM nitnelave/caffe
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

RUN yum -y install \
        python-devel \
        python-pip \
        vim \
        unzip \
        zip \
        && \
    yum clean all && \
    rm -rf /var/lib/apt/lists/*

# Install jupyter
RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        wheel \
        zmq \
        && \
    python -m ipykernel.kernelspec

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# TensorBoard, IPython
EXPOSE 8888

RUN mkdir /notebooks
WORKDIR "/notebooks"

CMD ["/run_jupyter.sh"]
