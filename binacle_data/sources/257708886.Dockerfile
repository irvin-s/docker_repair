FROM mozilla/lua_sandbox_extensions:master

WORKDIR /root

RUN yum makecache && \
    yum install -y git rpm-build c-compiler make curl gcc gcc-c++ zlib-devel \
    openssl-devel epel-release centos-release-scl source-highlight && \
    yum install -y devtoolset-6 && \
    curl -OL https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.tar.gz && \
    if [[ `sha256sum cmake-3.10.2-Linux-x86_64.tar.gz | awk '{print $1}'` != \
        "7a82b46c35f4e68a0807e8dc04e779dee3f36cd42c6387fd13b5c29fe62a69ea" ]]; then exit 1; fi && \
    (cd /usr && tar --strip-components=1 -zxf /root/cmake-3.10.2-Linux-x86_64.tar.gz)

# Use devtoolset-6
ENV PERL5LIB='PERL5LIB=/opt/rh/devtoolset-6/root//usr/lib64/perl5/vendor_perl:/opt/rh/devtoolset-6/root/usr/lib/perl5:/opt/rh/devtoolset-6/root//usr/share/perl5/vendor_perl' \
    X_SCLS=devtoolset-6 \
    PCP_DIR=/opt/rh/devtoolset-6/root \
    LD_LIBRARY_PATH=/opt/rh/devtoolset-6/root/usr/lib64:/opt/rh/devtoolset-6/root/usr/lib \
    PATH=/opt/rh/devtoolset-6/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    PYTHONPATH=/opt/rh/devtoolset-6/root/usr/lib64/python2.7/site-packages:/opt/rh/devtoolset-6/root/usr/lib/python2.7/site-packages

# Compile and install boost and libwt
#
# We have boost and libwt pinned and specific versions here, and build lua_sandbox
# from the master branch
RUN curl -OL https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz && \
    if [[ `sha256sum boost_1_65_1.tar.gz | awk '{print $1}'` != \
        "a13de2c8fbad635e6ba9c8f8714a0e6b4264b60a29b964b940a22554705b6b60" ]]; then exit 1; fi && \
    tar -zxf boost_1_65_1.tar.gz && \
    cd boost_1_65_1 && ./bootstrap.sh && (./b2 -j 4 link=static install >/dev/null || true) && cd .. && \
    curl -OL https://github.com/emweb/wt/archive/3.3.9.tar.gz && \
    if [[ `sha256sum 3.3.9.tar.gz | awk '{print $1}'` != \
        "0f0e2638001a312b0cb3f920a6eaf9692ebb4ad70f33068ca888724a7f482501" ]]; then exit 1; fi && \
    tar -zxf 3.3.9.tar.gz && mkdir -p wt-3.3.9/release && \
    cd wt-3.3.9/release && cmake cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=off -DSHARED_LIBS=OFF .. && \
    make -j4 && make install && cd ../..

# Add the hindsight_admin project and compile/package/install hindsight_admin
ADD . /root/hindsight_admin
RUN mkdir -p hindsight_admin/release && cd hindsight_admin/release && \
    cmake -DCMAKE_BUILD_TYPE=release .. && \
    make && cpack -G RPM && rpm -i *.rpm

# Add a default RUN command
CMD /usr/bin/su - hindsight -c 'cd /home/hindsight && /usr/share/hindsight_admin/run.sh'
