# Building Caffe binary with Cifar and OpenBLAS.
FROM centos:7 AS caffe

RUN yum makecache fast && yum groupinstall -y "Development tools"  && yum install -y git
RUN yum install -y epel-release
RUN yum install -y boost-devel gflags-devel glog-devel hdf5-devel leveldb-devel lmdb-devel opencv-devel protobuf-devel snappy-devel wget
RUN yum clean all

# Please don't install openblas-devel from linux distro - it will not work as multithreaded.
WORKDIR /root
RUN git clone --depth=1 https://github.com/BVLC/caffe
RUN git clone --depth=1 https://github.com/xianyi/OpenBLAS

# OpenBLAS build
WORKDIR /root/OpenBLAS
ENV USE_OPENMP=1 
RUN make -j --quiet libs
RUN make -j --quiet netlib
RUN make -j --quiet shared
RUN make -j install PREFIX=/opt/swan

### build 
WORKDIR /root/caffe
ADD caffe/Makefile.config Makefile.config
RUN LD_LIBRARY_PATH=/opt/swan/lib make -j

### install globaly
RUN cp .build_release/lib/libcaffe.so.1.0.0 /usr/lib/
RUN cp .build_release/tools/caffe /usr/local/bin
RUN ldconfig

# Data set preparation
WORKDIR /root/caffe
RUN ./data/cifar10/get_cifar10.sh
RUN  LD_LIBRARY_PATH=/opt/swan/lib ./examples/cifar10/create_cifar10.sh
WORKDIR /root/caffe/examples/cifar10/
RUN sed -i 's/GPU/CPU/' *.prototxt
ADD caffe/cifar10_quick_iter_5000.caffemodel.h5 cifar10_quick_iter_5000.caffemodel.h5

# Install into uniq folder matching swan depolyment
RUN mkdir -p /opt/swan/share/caffe/lib
RUN mkdir -p /opt/swan/share/caffe/bin
RUN mkdir -p /opt/swan/share/caffe/examples/cifar10
WORKDIR /root/caffe
RUN cp .build_release/lib/libcaffe.so.1.0.0 /opt/swan/share/caffe/lib
RUN cp .build_release/tools/caffe /opt/swan/share/caffe/bin
RUN cp -r ./examples/cifar10/cifar10_test_lmdb /opt/swan/share/caffe/examples/cifar10
RUN cp ./examples/cifar10/cifar10_quick_train_test.prototxt /opt/swan/share/caffe/examples/cifar10
RUN cp ./examples/cifar10/mean.binaryproto /opt/swan/share/caffe/examples/cifar10
RUN cp ./examples/cifar10/cifar10_quick_iter_5000.caffemodel.h5 /opt/swan/share/caffe/examples/cifar10
RUN cp /opt/swan/lib/libopenblas_haswellp-r0.2.20.dev.so /opt/swan/share/caffe/lib/libopenblas.so.0
ADD caffe/caffe.sh /opt/swan/bin/caffe.sh
ADD caffe/caffe-test.sh /opt/swan/bin/caffe-test.sh

# Buolding intel-cmt-cat.
FROM centos:7 AS intel-cmt-cat

RUN yum install -y gcc 
RUN yum install -y git make 
RUN git clone https://github.com/01org/intel-cmt-cat/
WORKDIR /intel-cmt-cat
RUN make SHARED=n

# Building memcached.
FROM centos:7 AS memcached

RUN yum makecache fast && yum groupinstall -y "Development tools"  && yum install -y git 
RUN yum install -y epel-release
RUN yum install -y wget libevent-devel
RUN wget http://memcached.org/files/memcached-1.4.35.tar.gz
RUN tar -xzvf memcached-1.4.35.tar.gz
WORKDIR /memcached-1.4.35
ADD memcached/thread-affinity.patch thread-affinity.patch 
RUN cat thread-affinity.patch | patch -p 1 
RUN ./configure --prefix=/usr/local/memcached
RUN make 

# Building stress-ng.
FROM centos:7 AS stress-ng

RUN yum install -y gcc 
RUN yum install -y git make 
RUN yum install -y wget tar
RUN wget http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.07.28.tar.gz
RUN tar -xzvf stress-ng-0.07.28.tar.gz
WORKDIR /stress-ng-0.07.28
RUN make 

# Builing final container that consists of workloads only.
FROM centos:7

RUN yum install -y epel-release
RUN yum install -y glog protobuf boost hdf5 leveldb lmdb opencv libgomp numactl libevent
RUN yum update -y
RUN yum clean all

COPY --from=caffe /opt /opt
COPY --from=intel-cmt-cat /intel-cmt-cat/pqos/pqos /opt/swan/bin/
COPY --from=intel-cmt-cat /intel-cmt-cat/rdtset/rdtset /opt/swan/bin/
COPY --from=memcached /memcached-1.4.35/memcached /opt/swan/bin/
COPY --from=stress-ng /stress-ng-0.07.28/stress-ng /opt/swan/bin/
RUN ln -sv /opt/swan/bin/* /usr/bin/
