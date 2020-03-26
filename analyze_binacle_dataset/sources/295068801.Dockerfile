# VERSION 1.0
# AUTHOR: Jason Kuruzovich ("jkuruzovich")
# DESCRIPTION: Airflow container
# SOURCE: 
# Adopted from: 
# AUTHOR: Matthieu "Puckel_" Roisil
# DESCRIPTION: Basic Airflow container
# BUILD: docker build --rm -t puckel/docker-airflow .
# SOURCE: https://github.com/puckel/docker-airflow

FROM jupyter/pyspark-notebook
MAINTAINER jkuruzovich
ARG AIRFLOW_VERSION=1.7.1.3
ARG jupyterhome
USER root
RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
        python-psycopg2 \
        libpq-dev 
USER $NB_USER
RUN conda install --quiet --yes \
    'pymongo' \
    'boto3' \
    'psycopg2' \
    'httplib2' \
    'oauth2client' \
    'requests' 
RUN pip install airflow[crypto,celery,postgres,hive,hdfs,jdbc]==$AIRFLOW_VERSION 
COPY config/jupyter_notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py
