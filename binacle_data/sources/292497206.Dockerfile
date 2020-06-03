FROM centos:7
LABEL maintainer cpfs@clustertech.com
RUN yum install -y epel-release && \
    yum install -y \
      attr \
      boost-devel \
      botan-devel \
      cmake \
      fuse \
      fuse-devel \
      gcc-c++ \
      libattr-devel \
      make \
      openssh-clients \
      patch \
      perl-Digest-MD5 \
      rpm-build \
      unzip \
      wget
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
    VERSION=${verstr//-/_} DESCRIPTION=$(cat README.md) \
      rpm/cpfs-os.spec.sh > rpmbuild/SPECS/cpfs-os.spec && \
    rpmbuild -bb --noclean rpmbuild/SPECS/cpfs-os.spec && \
    mkdir -p build/{package,install} && \
    cp -r rpmbuild/BUILDROOT/cpfs-os*/. build/install/ && \
    cp rpmbuild/RPMS/x86_64/* build/package && \
    rm -rf build/install/usr/lib/debug/.build-id
