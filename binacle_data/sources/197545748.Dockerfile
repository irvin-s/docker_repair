ARG BASE=gcc:9.1
FROM $BASE

ARG NPROCS=4

RUN apt-get update && apt-get install -y \
        python3-dev \
        python3-pip \
        && \
    pip3 install numpy scipy h5py && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install CMake
ENV CMAKE_DIR=/opt/cmake
RUN CMAKE_VERSION=3.13.4 && \
    CMAKE_VERSION_SHORT=3.13 && \
    CMAKE_URL=https://cmake.org/files/v${CMAKE_VERSION_SHORT}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
    CMAKE_SCRIPT=cmake-${CMAKE_VERSION}-Linux-x86_64.sh && \
    wget --quiet ${CMAKE_URL} --output-document=${CMAKE_SCRIPT} && \
    mkdir -p ${CMAKE_DIR} && \
    sh ${CMAKE_SCRIPT} --skip-license --prefix=${CMAKE_DIR} && \
    rm ${CMAKE_SCRIPT}
ENV PATH=${CMAKE_DIR}/bin:$PATH

# Install OpenMPI
ENV OPENMPI_DIR=/opt/openmpi
RUN OPENMPI_VERSION=3.1.3 && \
    OPENMPI_VERSION_SHORT=3.1 && \
    OPENMPI_SHA1=b3c60e2bdd5a8a8e758fd741f9a5bebb84da5e81 && \
    OPENMPI_URL=https://download.open-mpi.org/release/open-mpi/v${OPENMPI_VERSION_SHORT}/openmpi-${OPENMPI_VERSION}.tar.bz2 && \
    OPENMPI_ARCHIVE=openmpi-${OPENMPI_VERSION}.tar.bz2 && \
    SCRATCH_DIR=/scratch && mkdir -p ${SCRATCH_DIR} && cd ${SCRATCH_DIR} && \
    wget --quiet ${OPENMPI_URL} --output-document=${OPENMPI_ARCHIVE} && \
    echo "${OPENMPI_SHA1} ${OPENMPI_ARCHIVE}" | sha1sum -c && \
    mkdir -p openmpi && \
    tar -xf ${OPENMPI_ARCHIVE} -C openmpi --strip-components=1 && \
    mkdir -p build && cd build && \
    ../openmpi/configure --prefix=${OPENMPI_DIR} && \
    make -j${NPROCS} install && \
    rm -rf ${SCRATCH_DIR}
ENV PATH=${OPENMPI_DIR}/bin:$PATH

# Install LAPACK
RUN SCRATCH_DIR=/scratch && mkdir -p ${SCRATCH_DIR} && cd ${SCRATCH_DIR} && \
    git clone https://github.com/Reference-LAPACK/lapack-release.git && \
    cd lapack-release && \
    mkdir build && cd build && \
    cmake -DCMAKE_Fortran_FLAGS="-fPIC" -DCMAKE_C_FLAGS="-fPIC" .. && \
    make -j${NPROCS} install && \
    rm -rf ${SCRATCH_DIR}

# Install TPLS's
ENV TRUCHAS_TPL_DIR=/opt/truchas-tpl
RUN SCRATCH_DIR=/scratch && mkdir -p ${SCRATCH_DIR} && cd ${SCRATCH_DIR} && \
    git clone https://gitlab.com/truchas/truchas-tpl.git && \
    cd truchas-tpl && \
    mkdir build && cd build && \
    cmake -C ../config/linux-gcc.cmake -DCMAKE_INSTALL_PREFIX=${TRUCHAS_TPL_DIR} .. && \
    make -j${NPROCS} && \
    rm -rf ${SCRATCH_DIR}

# Install Truchas
ENV TRUCHAS_DIR=/opt/truchas
RUN SCRATCH_DIR=/scratch && mkdir -p ${SCRATCH_DIR} && cd ${SCRATCH_DIR} && \
    git clone https://gitlab.com/truchas/truchas.git && \
    cd truchas && \
    mkdir build && cd build && \
    cmake -C ../config/gcc-opt.cmake -D TRUCHAS_TPL_DIR=${TRUCHAS_TPL_DIR} -D CMAKE_INSTALL_PREFIX=${TRUCHAS_DIR} .. && \
    make -j${NPROCS} && make install && \
    rm -rf ${SCRATCH_DIR}



