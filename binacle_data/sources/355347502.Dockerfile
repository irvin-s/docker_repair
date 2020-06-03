#
# A base Docker image for Python-based computational neuroscience and neurophysiology
#

FROM neurodebian:jessie
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8

RUN apt-get update; apt-get install -y automake libtool build-essential openmpi-bin libopenmpi-dev git vim  \
                       wget python3 libpython3-dev libncurses5-dev libreadline-dev libgsl0-dev cython3 \
                       python3-pip python3-numpy python3-scipy python3-matplotlib python3-jinja2 python3-mock \
                       ipython3 python3-httplib2 python3-docutils python3-yaml \
                       subversion python3-venv python3-mpi4py python3-tables python3-h5py cmake

RUN useradd -ms /bin/bash docker
USER docker
ENV HOME=/home/docker
RUN mkdir $HOME/env; mkdir $HOME/packages

ENV VENV=$HOME/env/neurosci

# we run venv twice because of this bug: https://bugs.python.org/issue24875
# using the workaround proposed by Georges Racinet
RUN python3 -m venv $VENV && python3 -m venv --system-site-packages $VENV

RUN $VENV/bin/pip3 install --upgrade pip
RUN $VENV/bin/pip3 install parameters quantities neo "django<1.9" django-tagging future hgapi gitpython sumatra nixio
RUN $VENV/bin/pip3 install --upgrade nose ipython
