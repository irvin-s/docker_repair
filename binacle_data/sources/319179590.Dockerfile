FROM ubuntu:xenial

ARG wdir="/opt"
WORKDIR $wdir
ENV PATH="${wdir}/linuxdeployqt:${PATH}"

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:nixnote/nixnote2-stable -y && \
    add-apt-repository ppa:beineri/opt-qt-5.11.0-xenial -y && \
    apt-get update -qq

# last line is for webkit build from source
# qt pkg names: https://askubuntu.com/questions/508503/whats-the-development-package-for-qt5-in-14-04
RUN apt-get update && apt-get install -y git-core build-essential \
                              qt511base qt511tools qt511webchannel qt511script qt511translations qt511websockets qt511xmlpatterns qt511declarative qt511location qt511sensors \
                              wget curl make pkg-config \
                              libboost-dev libboost-test-dev libboost-program-options-dev libevent-dev libcurl4-openssl-dev \
                              libpoppler-qt5-dev libhunspell-dev nixnote2-tidy \
                              cmake build-essential perl python ruby flex gperf bison cmake ninja-build libfontconfig1-dev libicu-dev libsqlite3-dev zlib1g-dev libpng-dev libjpeg-dev libxslt1-dev libxml2-dev libhyphen-dev libxcomposite-dev libxrender-dev libglib2.0-dev libgstreamer-plugins-base1.0-dev


# install linuxdeployqt
RUN wget -nv "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage" && \
        chmod a+x ./linuxdeployqt-continuous-x86_64.AppImage && \
        ./linuxdeployqt-continuous-x86_64.AppImage --appimage-extract && \
        mv squashfs-root linuxdeployqt && \
        mv linuxdeployqt/AppRun linuxdeployqt/linuxdeployqt

RUN cd $wdir && git clone "https://github.com/robert7/nixnote2.git" && cd nixnote2 && git checkout master

CMD /bin/bash

