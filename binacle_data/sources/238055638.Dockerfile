FROM jupyter/scipy-notebook
RUN conda install --quiet --yes pandas
RUN conda install --quiet --yes -n python2 pandas
