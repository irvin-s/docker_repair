FROM jupyter/minimal-notebook:latest

USER jovyan

COPY auth/by_volume.py \
    /opt/conda/lib/python3.4/site-packages/notebook/auth/
COPY templates/login_register.html \
    /opt/conda/lib/python3.4/site-packages/notebook/templates

RUN conda install -y matplotlib==1.5.0 \
    numpy==1.10.2 \
    pandas==0.17.1 \
    scipy==0.16.1 \
    seaborn==0.6.0 \
    ipywidgets

RUN pip install jupyter_cms==0.2.1
# RUN pip install git+https://github.com/danielballan/nbexamples.git#egg=nbexamples

USER root
