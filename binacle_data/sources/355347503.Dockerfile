#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base:py2
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV NEST_VER=2.2.2 NRN_VER=7.4
ENV NEST=nest-$NEST_VER NRN=nrn-$NRN_VER

WORKDIR /home/docker/packages
RUN wget https://github.com/nest/nest-simulator/releases/download/v$NEST_VER/$NEST.tar.gz
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v$NRN_VER/$NRN.tar.gz
RUN tar xzf $NEST.tar.gz; tar xzf $NRN.tar.gz; rm $NEST.tar.gz $NRN.tar.gz

RUN mkdir $VENV/build
WORKDIR $VENV/build
RUN mkdir $NEST; \
    cd $NEST; \
    PYTHON=$VENV/bin/python $HOME/packages/$NEST/configure --with-mpi --prefix=$VENV --with-python=$VENV/bin/python --with-pynest-prefix=$VENV; \
    make; make install
RUN mkdir $NRN; \
    cd $NRN; \
    $HOME/packages/$NRN/configure --with-paranrn --with-nrnpython=$VENV/bin/python --disable-rx3d --without-iv --prefix=$VENV; \
    make; make install; \
    cd src/nrnpython; $VENV/bin/python setup.py install; \
    cd $VENV/bin; ln -s ../x86_64/bin/nrnivmodl


ENV PATH=$VENV/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN $VENV/bin/pip install brian nrnutils PyNN==0.7.5

WORKDIR /home/docker/
