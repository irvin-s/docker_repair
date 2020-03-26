FROM jupyter/scipy-notebook:latest
RUN bash -c 'for pkg in "graphistry[all]" python-igraph ; do pip install "$pkg" ; source activate python2 ; pip install "$pkg" ; source deactivate ; done' && pip install asyncio aiogremlin
RUN cd /tmp && git clone https://github.com/graphistry/pygraphistry.git && mv pygraphistry/demos /home/jovyan/work && rm -r pygraphistry
