FROM centos/devtoolset-7-toolchain-centos7
USER 0
WORKDIR /home/nakamoto
ENV USER_NAME=nakasendo \
    USER_UID=1001 \
    BASE_DIR=/home/nakasendo
ENV HOME=${BASE_DIR}

RUN yum update -y && \
    # yum install -y epel-release cryptopp-devel cryptopp keyutils-libs git which boost boost-devel python python-devel make gmp-devel mpfr-devel libmpc-devel glibc-devel.i686 libcc.i686 gcc-c++
    yum install -y epel-release && \
    yum install -y cryptopp-devel cryptopp git which python python-devel make && \
    git clone https://github.com/boostorg/boost --recursive && \
    cd boost && \
    ./bootstrap.sh --prefix=/usr/ && \
    ./b2 && \
    ./b2 install && \
    cd .. && \
    rm -rf boost
    # cp -r include/ /usr/ && \
    # cp -r lib/ /usr/

COPY include/  /usr/include/
COPY lib/ /usr/lib/
WORKDIR /home/nakasendo
USER 1000
ENTRYPOINT ["/bin/sh"]
