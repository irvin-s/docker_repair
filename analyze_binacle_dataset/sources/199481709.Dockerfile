FROM python:3.5
MAINTAINER John Readey <jreadey@hdfgroup.org>
ENV HDF5_MAJOR_REL       hdf5-1.10 
ENV HDF5_MINOR_REL       hdf5-1.10.0                                                
ENV HDF5_SRC_URL   http://www.hdfgroup.org/ftp/HDF5/releases                  
RUN cd /tmp                                                                        ; \ 
    echo "Getting: ${HDF5_SRC_URL}/${HDF5_MAJOR_REL}/${HDF5_MINOR_REL}/src/${HDF5_MINOR_REL}.tar"                ; \ 
    wget ${HDF5_SRC_URL}/${HDF5_MAJOR_REL}/${HDF5_MINOR_REL}/src/${HDF5_MINOR_REL}.tar                           ; \ 
    tar -xvf ${HDF5_MINOR_REL}.tar --directory /usr/local/src                      ; \
    rm ${HDF5_MINOR_REL}.tar                                                       ; \
    cd /usr/local/src/${HDF5_MINOR_REL}                                            ; \
    ./configure --prefix=/usr/local/hdf5                                           ; \
    make                                                                           ; \
    make check                                                                     ; \
    make install                                                                   ; \
    make check-install                                                             ; \
    for f in /usr/local/hdf5/bin/* ; do ln -s $f /usr/local/bin ; done             ; \
    pip install numpy                                                              ; \  
    cd /usr/local/src                                                              ; \
    git clone https://github.com/h5py/h5py.git                                     ; \
    cd h5py                                                                        ; \
    export HDF5_DIR=/usr/local/hdf5                                                ; \
    python setup.py build                                                          ; \
    python setup.py install            