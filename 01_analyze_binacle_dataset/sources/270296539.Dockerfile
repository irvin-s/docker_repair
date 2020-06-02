FROM centos:7 as qpid-dispatch-build
MAINTAINER Jakub Stejskal <stejskinek@gmail.com>

ARG QPID_DISPATCH_VERSION
ENV QPID_DISPATCH_VERSION ${QPID_DISPATCH_VERSION:-master}
ARG QPID_PROTON_VERSION
ENV QPID_PROTON_VERSION ${QPID_PROTON_VERSION:-master}
LABEL QPID_DISPATCH_VERSION=${QPID_DISPATCH_VERSION}

ENV MAESTRO_SUT_ROOT /opt/maestro/sut

# Install all required packages
RUN yum -y install gcc cmake libuuid-devel openssl-devel cyrus-sasl-devel cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-md5 swig python-devel java-1.8.0-openjdk-devel git make doxygen valgrind libuv libuv-devel libwebsockets-devel python-unittest2 && yum clean all -y

# Create a main directory and clone the qpid-proton repo from github
RUN mkdir -p ${MAESTRO_SUT_ROOT}/ && cd ${MAESTRO_SUT_ROOT}/ && \
    git clone https://git-wip-us.apache.org/repos/asf/qpid-proton.git -b ${QPID_PROTON_VERSION} && \
    cd ${MAESTRO_SUT_ROOT}/qpid-proton && mkdir -p ${MAESTRO_SUT_ROOT}/qpid-proton/build && \
    cd ${MAESTRO_SUT_ROOT}/qpid-proton/build && \
    cmake .. -DSYSINSTALL_BINDINGS=ON -DCMAKE_INSTALL_PREFIX=/usr/local -DSYSINSTALL_PYTHON=ON && \
    make install && make clean && \
    cd ${MAESTRO_SUT_ROOT} && rm -rf ${MAESTRO_SUT_ROOT}/qpid-proton

# Clone the qpid-dispatch git repo
RUN cd ${MAESTRO_SUT_ROOT}/ && \
    git clone https://git-wip-us.apache.org/repos/asf/qpid-dispatch.git -b ${QPID_DISPATCH_VERSION} && \
    mkdir -p ${MAESTRO_SUT_ROOT}/qpid-dispatch/build && \
    cd ${MAESTRO_SUT_ROOT}/qpid-dispatch/build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && make install && make clean && \
    cd ${MAESTRO_SUT_ROOT} && rm -rf ${MAESTRO_SUT_ROOT}/qpid-dispatch


FROM centos:7 as qpid-dispatch
EXPOSE 5672
RUN yum -y install libuuid openssl cyrus-sasl cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-md5 libuv libwebsockets && yum clean all -y
COPY --from=qpid-dispatch-build /usr/local /usr/local
RUN echo "/usr/local/lib64" >> /etc/ld.so.conf.d/local.conf
RUN ldconfig
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages/
# Start the dispatch router
CMD ["qdrouterd"]
