FROM centos:6

LABEL maintainer="conda-forge <conda-forge@googlegroups.com>"

# Set an encoding to make things work smoothly.
ENV LANG en_US.UTF-8

# Add a timestamp for the build. Also, bust the cache.
ADD http://worldclockapi.com/api/json/utc/now /opt/docker/etc/timestamp

# Resolves a nasty NOKEY warning that appears when using yum.
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# Install basic requirements.
RUN yum update -y && \
    yum install -y \
                   bzip2 \
                   make \
                   patch \
                   sudo \
                   tar \
                   which \
                   libXext-devel \
                   libXrender-devel \
                   libSM-devel \
                   libX11-devel \
                   mesa-libGL-devel && \
    yum clean all

# Install devtoolset 2.
RUN yum update -y && \
    yum install -y \
                   centos-release-scl \
                   yum-utils && \
    yum-config-manager --add-repo http://people.centos.org/tru/devtools-2/devtools-2.repo && \
    yum update -y && \
    yum install -y \
                   devtoolset-2-binutils \
                   devtoolset-2-gcc \
                   devtoolset-2-gcc-gfortran \
                   devtoolset-2-gcc-c++ && \
    yum clean all

# Run common commands
COPY scripts/run_commands /opt/docker/bin/run_commands
RUN /opt/docker/bin/run_commands

# Add a file for users to source to activate the `conda`
# environment `root` and the devtoolset compiler. Also
# add a file that wraps that for use with the `ENTRYPOINT`.
COPY linux-anvil/entrypoint_source /opt/docker/bin/entrypoint_source
COPY scripts/entrypoint /opt/docker/bin/entrypoint

# Ensure that all containers start with tini and the user selected process.
# Activate the `conda` environment `root` and the devtoolset compiler.
# Provide a default command (`bash`), which will start if the user doesn't specify one.
ENTRYPOINT [ "/opt/conda/bin/tini", "--", "/opt/docker/bin/entrypoint" ]
CMD [ "/bin/bash" ]
