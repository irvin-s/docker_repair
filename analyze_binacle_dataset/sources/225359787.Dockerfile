# Image: pubnative/pyspark-ci
# Cf: Makefile.

FROM jupyter/all-spark-notebook:7d427e7a4dde

LABEL maintainer Denis <denis@pubnative.net>

RUN jupyter labextension install @jupyterlab/git \
  && pip install jupyterlab-git \
  && jupyter serverextension enable \
    --py \
    --sys-prefix \
    jupyterlab_git

RUN pip install jupyter_contrib_nbextensions \
  && jupyter contrib nbextension install --user

COPY requirements.txt /tmp/requirements.txt

RUN pip install \
  --upgrade \
  --require-hashes \
  -r /tmp/requirements.txt
