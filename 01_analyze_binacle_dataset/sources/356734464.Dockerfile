# Python3 notebook + pydata stack + profile, extensions and slideshows

# Stack with no hub:
# $ cd python/py3base; docker build -t pdonorio_py3kbase .
# $ cd ../py3notebook; docker build -t pdonorio_py3knb .
# $ cd ../py3dataconda; docker build -t pdonorio_py3data .
# $ cd ../py3plus; docker build -t pdonorio_jupy3dataslide .

# Run notebook with /opt/start

FROM pdonorio/py3dataconda
#FROM pdonorio_py3data
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

###############################
# Create a basic profile for current user
RUN $CONDA_ACTIVATE && ipython3 profile create
# Link extensions from ipython to jupyter
RUN mkdir -p $HOME/.local/share/jupyter
RUN ln -s $HOME/.ipython/nbextensions $HOME/.local/share/jupyter/nbextensions

# Add offline use of mathjax
RUN $CONDA_ACTIVATE && python3 -m IPython.external.mathjax
# RUN wget https://github.com/mathjax/MathJax/archive/2.5.3.zip
# RUN python3 -m IPython.external.mathjax 2.5.3.zip

# check JUPYTER_CONFIG_DIR
ADD jupyconf.ipy /tmp/script.ipy
RUN $CONDA_ACTIVATE && ipython3 /tmp/script.ipy

# Live slideshows
RUN wget https://github.com/pdonorio/RISE/archive/master.tar.gz \
    && tar xvzf *.gz && cd *master && \
    $CONDA_ACTIVATE && python3 setup.py install \
    && rm -rf /tmp/*

# Other python packages
RUN $CONDA_ACTIVATE && pip install \
    jsonschema neomodel ipython-cypher networkx
# http://nicolewhite.github.io/neo4j-jupyter/twitter.html
# https://github.com/nicolewhite/neo4j-jupyter
    # plotly python-igraph

###############################
# Run directly the jupyter server
CMD [ "/bin/bash", "-c", "/opt/start" ]
# Standard port is 8888
