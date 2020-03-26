# Authors:
# Guilherme Caminha <gpkc@cin.ufpe.br>

FROM phusion/baseimage
MAINTAINER Guilherme Caminha <gpkc@cin.ufpe.br>

ENV HOME /home/scientific

ENV MOAB_DIR /usr
ENV VISIT_DIR /opt/visit
ENV MPI_HOME /usr
ENV PYTHONPATH /usr/lib/python3.6/site-packages
ENV PATH /usr/local/bin:$PATH
ENV LANG C.UTF-8

RUN set -x \
    && apt-get update \ 
    && apt-get -qy install \
        wget pkg-config git libopenblas-dev liblapack-dev \
        make cmake autoconf automake libtool \
        clang gcc g++ gfortran \
        libhdf5-mpich-dev libnetcdf-c++4 \
        libeigen3-dev libmetis-dev doxygen \
        liboce-foundation-dev liboce-modeling-dev liboce-ocaf-dev liboce-visualization-dev oce-draw \
        netgen libnglib-dev  \
        build-essential bzip2 tar m4 file swig \
	tcl tk libssl-dev \
    && apt-get clean


ENV GPG_KEY 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
ENV PYTHON_VERSION 3.6.3


# Install Python3
RUN set -ex \
	&& buildDeps=' \
		dpkg-dev \
		tcl-dev \
		tk-dev \
	' \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	\
	&& cd /usr/src/python \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
		--build="$gnuArch" \
		--enable-loadable-sqlite-extensions \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)" \
	&& make install \
	&& ldconfig \
	\
	&& apt-get purge -y --auto-remove $buildDeps \
	\
	&& find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' + \
	&& rm -rf /usr/src/python


# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
	&& ln -s idle3 idle \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& ln -s python3-config python-config


# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"

ENV PYTHON_PIP_VERSION 9.0.1


RUN set -ex; \
	\
	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
	\
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
	pip --version; \
	\
	find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' +; \
	rm -f get-pip.py


CMD ["/sbin/my_init"]

RUN pip install cython numpy pytest colorlog configobj pytest-runner
# Install mpi4py
WORKDIR $HOME
RUN cd $HOME \
    && git clone https://bitbucket.org/mpi4py/mpi4py \
    && cd $HOME/mpi4py \
    && python setup.py build \
    && python setup.py install \
    && cd $HOME \
    && rm -rf mpi4py


# Install MOAB
WORKDIR $HOME
RUN cd $HOME \
    && git clone https://bitbucket.org/fathomteam/moab.git \
    && cd $HOME/moab \
    && autoreconf -fi \
    && mkdir build \
    && cd $HOME/moab/build \
    && ../configure \
            --prefix=$MOAB_DIR \
            --with-mpi=/usr \
            --with-hdf5=/usr/lib/x86_64-linux-gnu/hdf5/mpich \
            --with-netcdf=/usr \
            --with-metis=/usr \
            --enable-optimize \
            --enable-debug \
            --enable-tools \
            --enable-pymoab \
            --enable-shared \
            CFLAGS='-O2 -fPIC -DPIC' \
            CXXFLAGS='-O2 -fPIC -DPIC' \
            FCFLAGS='-O2 -fPIC' \
            FFLAGS='-O2 -fPIC' \
    && make -j24\
    && make install \
    && cd $HOME/moab/build/pymoab \
    && python setup.py build \
    && python setup.py install \
    && cd $HOME \
    && rm -rf moab \
    && echo "export MOAB_DIR=$MOAB_DIR" >> $HOME/.bashrc \
    && echo "export PATH=$PATH:$MOAB_DIR/bin" >> $HOME/.bashrc \
    && echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MOAB_DIR/lib" >> $HOME/.bashrc



# Install Trilinos
ENV TRILINOS_VER 12.12.1
ENV CPATH /usr/local/include/python3.6m:$CPATH
RUN cd $HOME \
    && wget http://www.cmake.org/files/v3.2/cmake-3.2.2.tar.gz \
    && tar xzvf cmake-3.2.2.tar.gz \
    && cd $HOME/cmake-3.2.2 \
    && ./configure --prefix=/usr/local/cmake \
    && make -j24 && make install \
    && cd $HOME \
    && rm -rf cmake-3.2.2 && rm -f cmake-3.2.2.tar.gz \
    && wget http://trilinos.csbsju.edu/download/files/trilinos-$TRILINOS_VER-Source.tar.bz2 \
    && tar xjvf trilinos-$TRILINOS_VER-Source.tar.bz2 \
    && mkdir trilinos-$TRILINOS_VER-Source/build \
    && cd $HOME/trilinos-$TRILINOS_VER-Source/build/ \
    && /usr/local/cmake/bin/cmake -D CMAKE_INSTALL_PREFIX:PATH=/usr \
          \
          -D MPI_BASE_DIR:PATH=/usr \
          \
          -D CMAKE_BUILD_TYPE:STRING=Release \
          -D CMAKE_Fortran_COMPILER:FILEPATH=/usr/bin/mpif90 \
          -D BUILD_SHARED_LIBS:BOOL=ON \
          -D Trilinos_WARNINGS_AS_ERRORS_FLAGS:STRING="" \
          \
          -D Trilinos_ENABLE_ALL_PACKAGES:BOOL=OFF \
          -D Trilinos_ENABLE_ALL_OPTIONAL_PACKAGES:BOOL=OFF \
          -D Trilinos_ENABLE_ALL_FORWARD_DEP_PACKAGES:BOOL=OFF \
          -D Trilinos_ENABLE_Teuchos:BOOL=ON \
          -D Trilinos_ENABLE_Epetra:BOOL=ON \
          -D Trilinos_ENABLE_AztecOO:BOOL=ON \
          -D Trilinos_ENABLE_Amesos:BOOL=ON \
          -D Trilinos_ENABLE_PyTrilinos:BOOL=ON \
          \
          -D PyTrilinos_DISABLE_STRONG_WARN:BOOL=OFF\
          -D PyTrilinos_DOCSTRINGS:BOOL=OFF \
          -D PyTrilinos_ENABLE_EXAMPLES:BOOL=OFF \
          -D PyTrilinos_ENABLE_TESTS:BOOL=OFF\
          \
          -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
          -D Trilinos_ENABLE_TESTS:BOOL=OFF \
          \
          -D TPL_ENABLE_MATLAB:BOOL=OFF \
          -D TPL_ENABLE_Matio:BOOL=OFF \
          -D TPL_ENABLE_MPI:BOOL=ON \
          -D TPL_ENABLE_BLAS:BOOL=ON \
          -D TPL_ENABLE_LAPACK:BOOL=ON \
          -D TPL_ENABLE_QT:BOOL=OFF \
          -D TPL_ENABLE_X11:BOOL=OFF \
          -D TPL_ENABLE_MPI4PY:BOOL=ON \
          \
          -D CMAKE_VERBOSE_MAKEFILE:BOOL=OFF \
          -D Trilinos_VERBOSE_CONFIGURE:BOOL=OFF \
          .. \
    && make -j24 \
    && cd $HOME/trilinos-$TRILINOS_VER-Source/build/packages/PyTrilinos/src/PyTrilinos \
    && python -m compileall -b -l -f . \
    && cd $HOME/trilinos-$TRILINOS_VER-Source/build \
    && make install \
    && cd $HOME \
    && rm -rf trilinos-$TRILINOS_VER-Source trilinos-$TRILINOS_VER-Source.tar.bz2
