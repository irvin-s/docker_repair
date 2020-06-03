#
# A Docker image for running neuronal network simulations
#

FROM neuralensemble/base
MAINTAINER andrew.davison@unic.cnrs-gif.fr

ENV NEST_VER=2.14.0 NRN_VER=7.4
ENV NEST=nest-$NEST_VER NRN=nrn-$NRN_VER
ENV PATH=$PATH:$VENV/bin
RUN ln -s /usr/bin/2to3-3.4 $VENV/bin/2to3

WORKDIR $HOME/packages
RUN wget https://github.com/nest/nest-simulator/releases/download/v$NEST_VER/nest-$NEST_VER.tar.gz -O $HOME/packages/$NEST.tar.gz;
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v$NRN_VER/$NRN.tar.gz
RUN tar xzf $NEST.tar.gz; tar xzf $NRN.tar.gz; rm $NEST.tar.gz $NRN.tar.gz
RUN git clone --depth 1 https://github.com/INCF/libneurosim.git
RUN cd libneurosim; ./autogen.sh

RUN mkdir $VENV/build
WORKDIR $VENV/build
RUN mkdir libneurosim; \
    cd libneurosim; \
    PYTHON=$VENV/bin/python $HOME/packages/libneurosim/configure --prefix=$VENV; \
    make; make install; ls $VENV/lib $VENV/include
RUN mkdir $NEST; \
    cd $NEST; \
    ln -s /usr/lib/python3.4/config-3.4m-x86_64-linux-gnu/libpython3.4.so $VENV/lib/; \
    cmake -DCMAKE_INSTALL_PREFIX=$VENV \
          -Dwith-mpi=ON  \
          ###-Dwith-music=ON \
          -Dwith-libneurosim=ON \
          -DPYTHON_LIBRARY=$VENV/lib/libpython3.4.so \
          -DPYTHON_INCLUDE_DIR=/usr/include/python3.4 \
          $HOME/packages/$NEST; \
    make; make install
RUN mkdir $NRN; \
    cd $NRN; \
    $HOME/packages/$NRN/configure --with-paranrn --with-nrnpython=$VENV/bin/python --disable-rx3d --without-iv --prefix=$VENV; \
    make; make install; \
    cd src/nrnpython; $VENV/bin/python setup.py install; \
    cd $VENV/bin; ln -s ../x86_64/bin/nrnivmodl

RUN $VENV/bin/pip3 install lazyarray nrnutils PyNN
RUN $VENV/bin/pip3 install brian2

WORKDIR /home/docker/
RUN echo "source $VENV/bin/activate" >> .bashrc
