FROM nitnelave/nvidia
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

# Install the SSH server and MXNet dependencies
RUN yum -y install \
    openssh-server \
    python-devel \
    python-pip \
    && yum clean all

RUN pip install --no-cache numpy

# Fix the configuration
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#StrictModes yes/StrictModes no/' /etc/ssh/sshd_config && \
    sed -i 's@HostKey .*@HostKey /root/.ssh/ssh_host_rsa_key@' /etc/ssh/sshd_config

RUN git clone --recursive https://github.com/dmlc/mxnet.git && \
    cd mxnet && \
# Copy config.mk
    cp make/config.mk config.mk && \
# Set OpenBLAS
    sed -i 's/USE_BLAS = atlas/USE_BLAS = openblas/g' config.mk && \
    sed -i 's/USE_CUDA = 0/USE_CUDA = 1/g' config.mk && \
    sed -i 's/USE_DIST_KVSTORE = 0/USE_DIST_KVSTORE = 1/g' config.mk && \
    sed -i 's#ADD_CFLAGS =#ADD_CFLAGS = -I/usr/include/openblas/ \
                                        -I/usr/local/cuda-7.5/targets/x86_64-linux/include/#g' config.mk && \
    sed -i 's#ADD_LDFLAGS =#ADD_LDFLAGS = -L/usr/local/cuda-7.5/targets/x86_64-linux/lib/#g' config.mk && \
# Make
    make  -j"$(nproc)"

ENV PYTHONPATH ${PYTHONPATH}:/mxnet/python

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
