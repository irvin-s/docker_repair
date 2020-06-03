############################################################
# Dockerfile to run graphlab
# Based on Miniconda2 Image
############################################################

FROM continuumio/miniconda
MAINTAINER Sudhanshu Shekhar <sudhanshu.shekhar.iitd@gmail.com>

RUN mkdir -p /workspace
WORKDIR /workspace

RUN set -eux \
    && apt-get update && apt-get install -y \
    && apt-get install --no-install-recommends build-essential libssl-dev -y \
    && rm -rf /var/lib/apt/lists/*

RUN conda update --yes pip
RUN conda install -y ipython ipython-notebook

ARG GL_USER_EMAIL
ARG GL_USER_KEY
RUN pip install --upgrade --no-cache-dir https://get.graphlab.com/GraphLab-Create/2.1/${GL_USER_EMAIL}/${GL_USER_KEY}/GraphLab-Create-License.tar.gz

COPY requirements.txt /tmp/requirements.txt
RUN set -eux \
    && pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm -fv /tmp/zomato-requirements.txt \
    && conda clean --all --yes
