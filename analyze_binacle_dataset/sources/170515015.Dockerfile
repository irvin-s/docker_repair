FROM quay.io/fenicsproject/stable:2017.2.0.r4
MAINTAINER pf4d <mail@cummings.evan@gmail.com>

USER fenics
ENV  CSLVR_VERSION 2017.2.0
COPY WELCOME $FENICS_HOME/WELCOME

USER root

RUN apt-get update && \ 
    apt-get -y install python-pip \
                       python-netcdf4 \
                       python-matplotlib \
                       git \
                       curl \
                       wget \
                       subversion \
                       patch \
                       gmsh \ 
                       libxrender1 \
                       libglu1-mesa \
                       libsm6 \
                       libxcursor1 \
                       libgeos-dev \
                       texlive-base \
                       texlive-fonts-recommended \
                       texlive-latex-extra \
                       texlive-math-extra \
                       texlive-fonts-extra \
                       texlive-science


# get the latest python packages :
RUN pip install --upgrade colored \
                          termcolor \
                          shapely \
                          pyproj \
                          tifffile

# install libadjoint :
RUN git clone -b libadjoint-2017.2.0 https://bitbucket.org/dolfin-adjoint/libadjoint
RUN cd libadjoint && \
    mkdir build; cd build && \
    cmake -DCMAKE_INSTALL_PREFIX="/usr/local" .. && \
    make install && \
    cd ../.. && \
    rm -r libadjoint

# install dolfin-adjoint :
RUN git clone -b dolfin-adjoint-2017.2.0 https://bitbucket.org/dolfin-adjoint/dolfin-adjoint
ENV PYTHONPATH /home/fenics/dolfin-adjoint:$PYTHONPATH

# install ipopt with default packages -- these overlap with those used by 
# fenics, but it works, and is supported by IPOPT crew :
RUN svn co https://projects.coin-or.org/svn/Ipopt/stable/3.12 CoinIpopt
RUN cd CoinIpopt/ThirdParty/Metis && \
    ./get.Metis && \
    cd ../Lapack && \
    ./get.Lapack && \
    cd ../Blas && \
    ./get.Blas && \
    cd ../Mumps && \
    ./get.Mumps && \
    cd ../ASL && \
    ./get.ASL && \
    cd ../../ && \
    ./configure --prefix="/usr/local" && \
    make -j 8 && \
    make install && \
    cd ../ && \
    rm -r CoinIpopt

# install pyipopt :
RUN git clone https://github.com/xuy/pyipopt.git
RUN cd pyipopt && \
    python setup.py build && \
    python setup.py install && \
    cd ../ && \
    ldconfig && \
    rm -r pyipopt

# install basemap for matplotlib :
RUN git clone https://github.com/matplotlib/basemap.git
RUN cd basemap && \
    python setup.py install && \
    cd ..

# install gmsh :
RUN git clone https://gitlab.onelab.info/gmsh/gmsh.git
RUN cd gmsh && \
    mkdir build && \
    cd build && \
    cmake -D ENABLE_WRAP_PYTHON=ON \
          -D ENABLE_FLTK=ON \
          -D ENABLE_PRIVATE_API=ON \
          -D PYTHON_EXECUTABLE:FILEPATH=$(which python) \
          -D ENABLE_PETSC=OFF \
          -D ENABLE_SLEPC=OFF \
          -D ENABLE_PETSC4PY=OFF \
          -D ENABLE_MPI=ON \
          -D CMAKE_C_COMPILER=mpicc \
          -D CMAKE_CXX_COMPILER=mpicxx \
          -D CMAKE_Fortran_COMPILER=mpifort \
          -D CMAKE_INSTALL_PREFIX="/usr/local" .. && \
    make && \
    make install


## install cslvr :
#RUN git clone https://github.com/pf4d/cslvr
#ENV PYTHONPATH /home/fenics/cslvr:$PYTHONPATH

# finally, cleanup :
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



