FROM continuumio/anaconda3:latest

RUN apt-get update \
 && apt-get upgrade -y \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && apt-get install -y locales \
 && update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV SHELL /bin/bash

RUN apt-get install -y \
      build-essential \
      graphviz \
      nano \
      pandoc \
      tmux \
      unzip \
      vim \
 && apt-get clean

RUN conda update -y conda \
 && conda update -y anaconda \
 && conda install -y -c conda-forge \
      netcdf4 \
 && conda install -y \
      cvxopt \
      distributed \
      ipyparallel \
      xarray \
 && conda clean -y --all

RUN pip install --no-cache-dir \
      arch \
      deap \
      graphviz \
      hmmlearn \
      keras \
      pykalman \
      pymc3 \
      pywavelets \
      tensorflow

RUN find /opt/conda -not -perm -o=r | xargs chmod o+r \
 && rm -rf /tmp/* /var/tmp/*
