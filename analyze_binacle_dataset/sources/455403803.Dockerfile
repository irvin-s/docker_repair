FROM ubuntu:18.04
RUN apt-get update ; apt-get upgrade -y ; apt-get install -y gcc-8 g++-8 make cmake && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-8 && \
  update-alternatives --config gcc
ADD . native
RUN cd native && cmake . -DCMAKE_BUILD_TYPE=Release && make native_static -j8 && make native -j8 && make install
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib
RUN rm -rf native
WORKDIR /
