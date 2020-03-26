FROM ppc64le/centos:7

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN yum install -y \
  file \
  libX11 \
  libXau \
  libxcb \
  libXdmcp \
  libXext \
  libXrender \
  libXt \
  mesa-libGL \
  mesa-libGLU \
  openssh-clients \
  patch \
  rsync \
  util-linux \
  wget \
  which \
  bzip2 \
  xorg-x11-server-Xvfb \
  && yum clean all

WORKDIR /build_scripts
COPY install_miniconda.sh /build_scripts
RUN ./install_miniconda.sh

ENV PATH="/opt/conda/bin:${PATH}"
