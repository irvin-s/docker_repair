# Sequana docker builder
FROM ubuntu:16.04
MAINTAINER Thomas Cokelaer <thomas.cokelaer@pasteur.fr>

# Setup home environment
RUN useradd sequana
RUN mkdir /home/sequana && chown -R sequana: /home/sequana
RUN echo $HOME

# Instructions after ADD are not cached
ADD sequana_install.sh .
RUN /bin/bash sequana_install.sh

WORKDIR /home/sequana

CMD ["/bin/bash"]
