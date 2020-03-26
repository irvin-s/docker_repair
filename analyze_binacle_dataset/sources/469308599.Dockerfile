FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

MAINTAINER nana@developmentseed.org

RUN apt-get update && apt-get install -y \
        wget \
        vim \
        bzip2

#Install MINICONDA
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda.sh && \
        /bin/bash Miniconda.sh -b -p /opt/conda && \
        rm Miniconda.sh

ENV PATH /opt/conda/bin:$PATH

#Install ANACONDA Environment
RUN conda create -y -n jupyter_env python=3.6 anaconda && \
         /opt/conda/envs/jupyter_env/bin/pip install tensorflow-gpu keras==2.1.5 jupyter-tensorboard jupyterlab opencv-python==3.3.0.9

#Launch JUPYTER COMMAND
CMD /opt/conda/envs/jupyter_env/bin/jupyter notebook --ip=* --no-browser --debug --allow-root --notebook-dir=/example
