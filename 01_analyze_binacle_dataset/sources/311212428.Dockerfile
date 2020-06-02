#FROM oldfrostdragon/qt-5.7-xenial-docker:latest
#FROM rabits/qt:5.11-desktop
FROM metacoma/qt-5.11:trusty
WORKDIR /tmp/
USER root
RUN apt-get purge -y libcurl3 libcurl3-gnutls
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --upgrade    \
  git build-essential                                 \
  libxtst-dev                                         \
  libx11-dev                                          \
  libxinerama-dev                                     \
  libcurlpp-dev                                       \
  libcurl4-openssl-dev                                \
  libegl1-mesa                                        \
  libboost-all-dev                                    \
  wget                                                \
  cmake                                               \
  libfuse2                                            \
  libxdo3                                             \
  libxdo-dev                                          \
  autoconf                                            \
  m4

RUN apt-get install -y libcurl4-nss-dev
RUN apt-get install -y libcurl4-openssl-dev
#USER jenkins
RUN git clone https://github.com/Robot/robot
WORKDIR /tmp/robot
RUN git checkout a19be1863405fa4dd5c970946d0f3f59d06b74f1
RUN make -j4 build
USER root
RUN make install
ADD https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage /opt/Qt/5.11.0/gcc_64/bin/linuxdeployqt
RUN chmod +x /opt/Qt/5.11.0/gcc_64/bin/linuxdeployqt
WORKDIR /tmp
ENV LD_LIBRARY_PATH=/opt/Qt/5.11.0/gcc_64/lib/
WORKDIR /tmp
ADD https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/xcb-util-wm/0.4.1-1ubuntu1/xcb-util-wm_0.4.1.orig.tar.gz /tmp/xcb-util-wm_0.4.1.orig.tar.gz
RUN tar zxvf xcb-util-wm_0.4.1.orig.tar.gz
WORKDIR /tmp/xcb-util-wm-0.4.1
RUN ./configure
RUN make
RUN make install
RUN ldconfig -v
WORKDIR /tmp
RUN git clone https://github.com/NixOS/patchelf
WORKDIR /tmp/patchelf
RUN ./bootstrap.sh            &&\
    ./configure               &&\
    make                      &&\
    make install
WORKDIR /tmp
ADD https://github.com/probonopd/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage /usr/local/bin/appimagetool
RUN chmod +x /usr/local/bin/appimagetool
ADD --chown=root:root http://res.freestockphotos.biz/pictures/16/16161-illustration-of-a-silver-key-pv.png /tmp/silverkey-icon.png
RUN chmod a+rw /tmp/silverkey-icon.png
WORKDIR /
#USER jenkins
