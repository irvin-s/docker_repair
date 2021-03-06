#-------------------------------------------------------------------------------
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
#-------------------------------------------------------------------------------
FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER H2O.ai <ops@h2o.ai>

ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

RUN \
  apt-get -q -y update && \
  apt-get -y --no-install-recommends  install \
    apt-utils \
    curl \
    wget \
    cpio \
    git \
    lcov \
    python-software-properties \
    software-properties-common && \
  add-apt-repository ppa:deadsnakes/ppa && \
  apt-get -q -y update && \
  apt-get -y --no-install-recommends  install \
    python3.7 \
    python3.7-dev \
    python3.6 \
    python3.6-dev \
    python3.6-venv \
    python3.5 \
    python3.5-dev \
    python3-pip && \
  update-alternatives --install /usr/bin/python python /usr/bin/python3.6 100 && \
  python -m pip install --upgrade pip && \
  apt-get clean && \
  rm -rf /var/cache/apt/*

RUN \
  pip install --upgrade pip && \
  pip install --upgrade setuptools && \
  pip install --upgrade python-dateutil && \
  pip install --upgrade numpy && \
  pip install --upgrade colorama && \
  pip install --upgrade typesentry && \
  pip install --upgrade blessed && \
  pip install --upgrade pandas && \
  pip install --upgrade pytest && \
  pip install --upgrade virtualenv && \
  pip install --upgrade wheel

RUN \
    virtualenv --python=python3.5 /envs/datatable-py35-with-pandas && \
    . /envs/datatable-py35-with-pandas/bin/activate && \
    pip install --upgrade pandas numpy && \
    deactivate && \
    virtualenv --python=python3.6 /envs/datatable-py36-with-pandas && \
    . /envs/datatable-py36-with-pandas/bin/activate && \
    pip install --upgrade pandas numpy && \
    deactivate && \
    virtualenv --python=python3.6 /envs/datatable-py36-with-numpy && \
    . /envs/datatable-py36-with-numpy/bin/activate && \
    pip install --upgrade numpy && \
    deactivate && \
    virtualenv --python=python3.6 /envs/datatable-py36 && \
    . /envs/datatable-py36/bin/activate && \
    deactivate && \
    virtualenv --python=python3.7 /envs/datatable-py37-with-pandas && \
    . /envs/datatable-py37-with-pandas/bin/activate && \
    pip install --upgrade pandas numpy && \
    deactivate && \
    chmod -R a+w /envs

# A separated layer to collect core dumps
RUN mkdir -p /tmp/cores && chmod a+rwx /tmp/cores
