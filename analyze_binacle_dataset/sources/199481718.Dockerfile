FROM centos
MAINTAINER John Readey <jreadey@hdfgroup.org>                                            
ENV HDF5_SRC_URL   https://bitbucket.hdfgroup.org/rest/archive/latest/projects/~JHENDERSON/repos/rest-vol                 
RUN yum -y install gcc gcc-c++                                                        ; \
    yum -y install yajl                                                               ; \
    yum -y install yajl-devel                                                         ; \
    yum -y install wget                                                               ; \
    yum -y install unzip                                                              ; \
    yum -y install make                                                               ; \
    yum -y install which                                                              ; \
    yum -y install autofconf                                                          ; \
    yum -y install libtool                                                            ; \
    yum -y install curl-devel                                                         ; \
    yum -y install cmake                                                              ; \
    cd /usr/local/src                                                                 ; \
    wget ${HDF5_SRC_URL}/archive?format=zip -O hdf5rest.zip                           ; \
    mkdir hdf5rest                                                                    ; \
    cd hdf5rest                                                                       ; \
    unzip ../hdf5rest.zip                                                             ; \                                                      
    ./build_vol_autotools.sh
 