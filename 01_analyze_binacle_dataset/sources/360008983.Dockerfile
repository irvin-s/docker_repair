# Base image of the IPython/Jupyter notebook, with conda
# Intended to be used in a tmpnb installation
# Customized from https://github.com/jupyter/docker-demo-images/tree/master/common
FROM debian:jessie

MAINTAINER Andrew Osheroff <andrewosh@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y &&\
    apt-get install --fix-missing -y curl git vim wget build-essential python-dev bzip2 libsm6\
      locales nodejs-legacy npm python-virtualenv python-pip gcc gfortran libglib2.0-0 python-qt4 &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*tmp

# set utf8 locale:
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# We run our docker images with a non-root user as a security precaution.
# main is our user
RUN useradd -m -s /bin/bash main

EXPOSE 8888

USER main
ENV HOME /home/main
ENV SHELL /bin/bash
ENV USER main
WORKDIR $HOME

# Add helper scripts
ADD start-notebook.sh /home/main/

USER main

# Install Anaconda and Jupyter
RUN wget https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -b &&\
    rm Miniconda-latest-Linux-x86_64.sh
ENV PATH $HOME/miniconda2/bin:$PATH

RUN /home/main/miniconda2/bin/pip install --upgrade pip

RUN pip install jupyter

ENV SHELL /bin/bash
