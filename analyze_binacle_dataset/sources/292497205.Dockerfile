FROM centos:6
LABEL maintainer cpfs@clustertech.com
RUN yum install -y epel-release && \
    yum install -y \
      attr \
      bzip2-devel \
      cmake \
      fuse \
      gcc-c++ \
      gettext-devel \
      libattr-devel \
      libtool \
      make \
      patch \
      perl-Digest-MD5 \
      rpm-build \
      unzip \
      wget \
      zlib-devel
RUN cd && mkdir build && cd build && \
    wget https://sourceforge.net/projects/boost/files/boost/1.53.0/boost_1_53_0.zip/download -O download.zip && \
    unzip download.zip && \
    cd boost_1_53_0 && \
    ./bootstrap.sh --prefix=/usr/local && \
    ./b2 --without-python install && \
    echo >> /usr/local/include/boost/fusion/tuple/detail/preprocessed/tuple.hpp && \
    cd ../.. && \
    rm -rf build
RUN cd && mkdir build && cd build && \
    wget https://botan.randombit.net/releases/Botan-1.10.15.tgz && \
    tar xzvf Botan-1.10.15.tgz && \
    cd Botan-1.10.15 && \
    ./configure.py --prefix=/usr/local && \
    make install && \
    ln -sfT botan-1.10/botan /usr/local/include/botan && \
    cd ../.. && \
    rm -rf build
RUN cd && mkdir build && cd build && \
    wget https://github.com/libfuse/libfuse/archive/fuse_2_9_5.zip && \
    unzip fuse_2_9_5.zip && \
    cd libfuse-fuse_2_9_5 && \
    ./makeconf.sh && \
    ./configure && \
    make install && \
    cd ../.. && \
    rm -rf build
RUN yum -y update && yum clean all && useradd -m builder \
    && usermod -a -G audio builder
ADD . /home/builder/
RUN chown -R builder.builder /home/builder/
USER builder
RUN cd && \
    ./build_dep
RUN cd && \
    tar czf /tmp/cpfs-os.tar.gz * && \
    mkdir -p rpmbuild/{SPECS,SOURCES} && \
    mv /tmp/cpfs-os.tar.gz rpmbuild/SOURCES && \
    verstr=$(tr -d \" < src/cpfs/version.ipp) && \
    VERSION=${verstr//-/_}  DESCRIPTION=$(cat README.md) \
      rpm/cpfs-os.spec.sh > rpmbuild/SPECS/cpfs-os.spec.tmp && \
    sed -e 's/%cmake -DCMAKE/%cmake -DLINK_STATIC=1 -DCMAKE/' < rpmbuild/SPECS/cpfs-os.spec.tmp > rpmbuild/SPECS/cpfs-os.spec && \
    rpmbuild -bi rpmbuild/SPECS/cpfs-os.spec && \
    mkdir -p build/{package,install} && \
    cp -r rpmbuild/BUILDROOT/cpfs-os*/. build/install/ && \
    rpmbuild -bb --short-circuit rpmbuild/SPECS/cpfs-os.spec && \
    cp rpmbuild/RPMS/x86_64/* build/package && \
    rm -rf build/install/usr/lib/debug/.build-id
