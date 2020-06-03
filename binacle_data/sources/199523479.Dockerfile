# Sequana docker builder
FROM sequana/sequana_core:latest
MAINTAINER Thomas Cokelaer <thomas.cokelaer@pasteur.fr>

# Instructions after ADD are not cached
ADD sequana_install.sh .
RUN /bin/bash sequana_install.sh


ENV PATH $PATH:/home/sequana/miniconda3/bin
ENV MATPLOTLIBRC=/home/sequana
ENV MPLBACKEND="agg"
CMD ["/bin/bash"]
