# Authors:
# Guilherme Caminha <gpkc@cin.ufpe.br>

FROM padmec/pymoab-pytrilinos:3.6
MAINTAINER Guilherme Caminha <gpkc@cin.ufpe.br>

RUN git clone https://github.com/gpkc/ELLIPTIc.git
WORKDIR $HOME/ELLIPTIc

RUN python setup.py build
RUN python setup.py install

WORKDIR $HOME
