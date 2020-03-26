###########################################
## Notebook with Pyspark in Python 2/3, R, Scala
###########################################

FROM jupyter/all-spark-notebook
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

# Dependencies
RUN apt-get install -y libyaml-dev
RUN chown jovyan /opt
# Main notebook user
USER jovyan
# install libs
RUN pip install plumbum jinja2

###############################
# Add mrjob from Yelp
WORKDIR /opt
# Install and not remove from installation!
RUN git clone https://github.com/Yelp/mrjob \
    && cd mrjob && pip install -e .

###############################
# Add offline use of mathjax
RUN python3 -m IPython.external.mathjax
# RUN wget https://github.com/mathjax/MathJax/archive/2.5.3.zip
# RUN python3 -m IPython.external.mathjax 2.5.3.zip

###############################
# Live slideshows
USER root
RUN rm -rf /tmp/*
USER jovyan
RUN wget https://github.com/pdonorio/RISE/archive/master.tar.gz \
    && tar xvzf *.gz && cd *master && \
    python3 setup.py install \
    && rm -rf /tmp/*

###############################
# The end
USER root
#WORKDIR /home/jovyan/work
WORKDIR /data
