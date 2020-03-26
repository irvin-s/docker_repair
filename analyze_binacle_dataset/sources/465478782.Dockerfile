
ARG BASE_IMAGE=ubuntu:18.04
FROM $BASE_IMAGE

# Noninteractive frontend
ARG DEBIAN_FRONTEND=noninteractive

#
# Install anything needed in the system
#
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y git python3-minimal python3-pip autoconf libtool

#
# Install googletest
#
RUN apt-get install -y libgtest-dev cmake
WORKDIR /usr/src/gtest
RUN cmake CMakeLists.txt && make -j16 && cp *.a /usr/lib

# Set the working directory back to the root home folder
WORKDIR /root

# Install valgrind
RUN apt-get install -y valgrind

# Install msgpack
RUN pip3 install msgpack
WORKDIR /usr/src
RUN git clone https://github.com/msgpack/msgpack-c.git
WORKDIR /usr/src/msgpack-c
RUN cmake -DMSGPACK_CXX11=ON . && make install

# Install graphics
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  libgl1-mesa-dri \
  menu \
  net-tools \
  openbox \
  python-pip \
  sudo \
  supervisor \
  tint2 \
  x11-xserver-utils \
  x11vnc \
  xinit \
  xserver-xorg-video-dummy \
  xserver-xorg-input-void \
  websockify \
  wget && \
  rm -f /usr/share/applications/x11vnc.desktop && \
  apt-get remove -y python-pip && \
  wget https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  pip install supervisor-stdout && \
  apt-get -y clean

COPY third-party/docker-opengl/etc/skel/.xinitrc /etc/skel/.xinitrc

RUN useradd -m -s /bin/bash user
USER user

RUN cp /etc/skel/.xinitrc /home/user/
USER root
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user


RUN git clone https://github.com/kanaka/noVNC.git /opt/noVNC && \
  cd /opt/noVNC && \
  git checkout 6a90803feb124791960e3962e328aa3cfb729aeb && \
  ln -s vnc_auto.html index.html

# noVNC (http server) is on 6080, and the VNC server is on 5900
EXPOSE 6080 5900

COPY third-party/docker-opengl/etc /etc
COPY third-party/docker-opengl/usr /usr

ENV DISPLAY :0
