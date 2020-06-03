FROM fedora:26
LABEL maintainer="Graeme Stewart <graeme.andrew.stewart@cern.ch>"

USER root

RUN adduser gks
RUN usermod -aG wheel gks
COPY wheel /etc/sudoers.d/wheel

RUN dnf remove -y vim-minimal
RUN dnf install -y sudo strace xorg-x11-xauth
RUN dnf install -y emacs geany jed vim nano
RUN dnf install -y gcc-c++ cmake git
RUN dnf install -y tbb tbb-doc tbb-devel 
RUN dnf install -y boost boost-devel

RUN dnf clean all

USER gks
WORKDIR /home/gks
RUN mkdir -p .local/share
RUN git clone https://github.com/graeme-a-stewart/cpp-concurrency.git
WORKDIR /home/gks/cpp-concurrency
RUN git submodule init
RUN git submodule update

WORKDIR /home/gks
CMD /bin/bash -l
