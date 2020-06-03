FROM centos:7

RUN yum update -y && yum install -y \
        cmake \
        curl \
        expect \
        gcc-c++ \
        git \
        make \
        openssl-devel \
        rpm-build \
        rpm-sign \
        tar \
        yajl-devel \
    && yum -y clean all \
    && rm -rf /var/cache/yum /tmp/yum.log \
    && cd /tmp \
    && curl -sSLO https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.bz2 \
    && tar xjf boost_1_58_0.tar.bz2 \
    && cd /tmp/boost_1_58_0 \
    && ./bootstrap.sh --with-libraries=atomic,chrono,date_time,filesystem,program_options,regex,system,thread,timer \
    && ./b2 cxxflags="-std=c++11" linkflags="-std=c++11" install \
    && rm -rf /tmp/boost_1_58_0 /tmp/boost_1_58_0.tar.bz2
ENV BOOST_ROOT=/usr/local
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$BOOST_ROOT/lib"

