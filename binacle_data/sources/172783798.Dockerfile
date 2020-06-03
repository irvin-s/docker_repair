FROM jupyter/minimal-notebook
MAINTAINER danielc@pobox.com

RUN conda install -yq bokeh
