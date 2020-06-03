FROM probcomp/notebook

# install the probcomp libraries
COPY files/conda_probcomp_edge.txt /tmp/
RUN conda install -n python2 --quiet --yes -c probcomp/label/edge -c cidermole -c fritzo -c ursusest \
    --file /tmp/conda_probcomp_edge.txt && \
    conda remove -n python2 --quiet --yes --force qt pyqt && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
