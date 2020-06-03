FROM nginx

MAINTAINER Thomas Wollmann <thomas.wollmann@bioquant.uni-heidelberg.de>

RUN apt-get update && apt-get install -y wget bzip2

ENV PV_VERSION=5.4.0 \
    PV_VERSION_MAJOR=5.4 \
    VIZ_VERSION=2.1.4 \
    MESA_VERSION=13.0.3

RUN apt-get -q update && \
    apt-get -q -y upgrade && \
    apt-get -q -y install build-essential software-properties-common && \
    apt-get -q -y install curl wget git python python-dev && \
    curl -s https://bootstrap.pypa.io/get-pip.py | python2

# Install cmake
ENV CMAKE_VERSION=3.5.2
RUN wget http://www.cmake.org/files/v3.5/cmake-$CMAKE_VERSION.tar.gz && \
    tar -xvzf cmake-$CMAKE_VERSION.tar.gz && \
    cd cmake-$CMAKE_VERSION/ && \
    ./configure && \
    make -j4  && \
    make install && \
    cd .. && \
    rm -R cmake-$CMAKE_VERSION && \
    rm -R cmake-$CMAKE_VERSION.tar.gz

# Install LLVM
ENV LLVM_VERSION=3.9.1
RUN apt-get install -y pkg-config libpthread-stubs0-dev libomxil-bellagio-dev && \
    mkdir -p /root/build && cd /root/build && \
    wget http://releases.llvm.org/$LLVM_VERSION/llvm-$LLVM_VERSION.src.tar.xz && tar -xvJf llvm-$LLVM_VERSION.src.tar.xz && \
    mkdir -p /root/build/llvm && cd /root/build/llvm && \
    cmake                                           \
      -DCMAKE_BUILD_TYPE=Release                    \
      -DLLVM_BUILD_LLVM_DYLIB=ON                    \
      -DLLVM_ENABLE_RTTI=ON                         \
      -DLLVM_INSTALL_UTILS=ON                       \
      -DLLVM_TARGETS_TO_BUILD:STRING=X86            \
       ../llvm-$LLVM_VERSION.src && \
    make -j4  && \
    make install && \
    cd / && rm -rf /root/build

# Install OSMesa
RUN wget ftp://ftp.freedesktop.org/pub/mesa/older-versions/13.x/$MESA_VERSION/mesa-$MESA_VERSION.tar.gz && \
    tar -xvzf mesa-$MESA_VERSION.tar.gz && \
    cd mesa-$MESA_VERSION/ && \
    ./configure                                         \
      --enable-opengl --disable-gles1 --disable-gles2   \
      --disable-va --disable-xvmc --disable-vdpau       \
      --enable-shared-glapi                             \
      --disable-texture-float                           \
      --enable-gallium-llvm --enable-llvm-shared-libs   \
      --with-gallium-drivers=swrast,swr                 \
      --disable-dri --with-dri-drivers=                 \
      --disable-egl --with-egl-platforms= --disable-gbm \
      --disable-glx                                     \
      --disable-osmesa --enable-gallium-osmesa && \
    make -j4  && \
    make install && \
    cd .. && \
    rm -R mesa-$MESA_VERSION && \
    rm -R mesa-$MESA_VERSION.tar.gz
 
RUN mkdir -p /root/build && cd /root/build && \
    apt-get -q update && \
    git clone git://paraview.org/ParaView.git pv-git && cd pv-git && \
    git checkout v$PV_VERSION && git submodule init && git submodule update && \

    mkdir -p /root/build/pv-bin && cd /root/build/pv-bin && \
    cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D BUILD_TESTING:BOOL=OFF \
        -D PARAVIEW_BUILD_QT_GUI:BOOL=OFF \
        -D PARAVIEW_ENABLE_PYTHON:BOOL=ON \
        -D PARAVIEW_INSTALL_DEVELOPMENT_FILES:BOOL=OFF \
        -D OPENGL_INCLUDE_DIR=/usr/include \
        -D OPENGL_gl_LIBRARY="" \
        -D VTK_USE_X:BOOL=OFF \
        -D VTK_OPENGL_HAS_OSMESA:BOOL=ON \
        -D OSMESA_INCLUDE_DIR=/usr/include \
        -D OSMESA_LIBRARY=/usr/local/lib/libOSMesa.so \
        ../pv-git && \
    make -j4 && make install && \
    cd / && rm -rf /root/build

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get -q -y install nodejs && \
    npm install -g pvw-visualizer@$VIZ_VERSION && \
    mkdir /usr/local/opt/ && \
    mkdir /Applications

ADD nginx.conf /etc/nginx/nginx.conf

RUN mkdir /import
RUN mkdir /export
WORKDIR /import

ENV DEBUG=false \
    GALAXY_WEB_PORT=10000 \
    NOTEBOOK_PASSWORD=none \
    CORS_ORIGIN=none \
    DOCKER_PORT=none \
    API_KEY=none \
    HISTORY_ID=none \
    REMOTE_HOST=none \
    GALAXY_URL=none

EXPOSE 8777

ADD startup.sh /
RUN chmod +x /startup.sh
CMD /startup.sh
