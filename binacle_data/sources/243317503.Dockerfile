FROM ubuntu:16.04
MAINTAINER George Paraskevopoulos <georgepar.91@gmail.com>

ARG OPENFST_VERSION=1.4.1
ARG NUM_BUILD_CORES=8
ENV OPENFST_VERSION ${OPENFST_VERSION}
ENV NUM_BUILD_CORES ${NUM_BUILD_CORES}

# These are not installed from check_dependencies because the binaries are installed by python and libtool-bin

RUN apt-get update
RUN apt-get install -y sudo git apt-utils
RUN apt-get install -y python2.7 libtool python libtool-bin
RUN ln -s -f bash /bin/sh

RUN git clone https://github.com/kaldi-asr/kaldi.git /kaldi --depth=1

RUN /kaldi/tools/extras/check_dependencies.sh | grep "sudo apt-get" | \
            while read -r cmd; do \
                  $cmd -y ; \
            done

RUN pushd /kaldi/tools; \
            make OPENFST_VERSION=${OPENFST_VERSION} -j${NUM_BUILD_CORES}; \
            popd

RUN pushd /kaldi/src; ./configure --shared && make depend && make -j${NUM_BUILD_CORES}; popd

ENTRYPOINT ["bin/bash"]
