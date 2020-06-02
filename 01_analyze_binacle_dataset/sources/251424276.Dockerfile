FROM amazonlinux
MAINTAINER Alexander Ignatyev

## Install dependencies
RUN yum install -y curl\
    make \
    gcc \
    gmp-devel \
    pcre-devel \
    blas-devel \
    lapack-devel \
    perl \
    tar \
    which \
    xz \
    zlib-devel

RUN ln -s /lib64/libtinfo.so.5 /lib64/libtinfo.so

ENV GHC_VERSION=8.0.2
## Install stack
RUN mkdir -p /opt/stack/bin
RUN curl -L https://www.stackage.org/stack/linux-x86_64 | tar xz --wildcards --strip-components=1 -C /opt/stack/bin '*/stack'
ENV PATH /opt/stack/bin/:$PATH
RUN stack setup $GHC_VERSION
