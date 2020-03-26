FROM pyda:python-2.7
MAINTAINER Brandon Amos <brandon.amos.cs@gmail.com>

RUN apt-get update && apt-get install -y \
    cmake \
    curl \
    libatlas-dev \
    libavcodec-dev \
    libavformat-dev \
    libboost-all-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && apt-get install -y software-properties-common
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash -e
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch && ./install.sh

RUN ~/torch/install/bin/luarocks install nn
RUN ~/torch/install/bin/luarocks install dpnn
RUN ~/torch/install/bin/luarocks install image
RUN ~/torch/install/bin/luarocks install optim
RUN ~/torch/install/bin/luarocks install csvigo
RUN ~/torch/install/bin/luarocks install cutorch
RUN ~/torch/install/bin/luarocks install cunn
RUN ~/torch/install/bin/luarocks install cudnn

RUN cd ~ && \
    mkdir -p src && \
    cd src && \
    curl -L \
         https://github.com/davisking/dlib/releases/download/v18.16/dlib-18.16.tar.bz2 \
         -o dlib.tar.bz2 && \
    tar xf dlib.tar.bz2 && \
    cd dlib-18.16/python_examples && \
    mkdir build && \
    cd build && \
    cmake ../../tools/python && \
    cmake --build . --config Release && \
    cp dlib.so ..

RUN cp /root/src/dlib-18.16/python_examples/build/dlib.so /usr/lib/python2.7/dist-packages/

EXPOSE 9000
