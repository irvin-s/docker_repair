FROM damsl/k3-vanilla:latest
WORKDIR /software

RUN apt-get update && apt-get install -y python-pip libyaml-dev libprotobuf-dev libgoogle-glog-dev libsvn-dev libapr1-dev python-dev
RUN apt-get install -y google-perftools libgoogle-perftools-dev
ADD intelpcm.tar.gz /software/

RUN mv /software/intelpcm/lib/* /usr/local/lib && mv /software/intelpcm/include/* /usr/local/include 
ADD libmesos.tar.gz /software/
ADD mesos-eggs.tar.gz /software/
ADD mesos-include.tar.gz /software/

RUN mv libmesos/* /usr/local/lib
RUN cp -r mesos /usr/local/include
RUN apt-get install -y cmake
RUN easy_install mesos-eggs/mesos.*
RUN pip install pyyaml
RUN git clone https://github.com/3rdparty/stout.git && mv stout/include/stout /usr/include/
ENV LD_LIBRARY_PATH /usr/local/lib/:/usr/lib/x86_64-linux-gnu/
RUN ulimit -c unlimited

RUN wget https://github.com/jemalloc/jemalloc/archive/3.6.0.tar.gz && tar -xvf 3.6.0.tar.gz
WORKDIR /software/jemalloc-3.6.0
RUN ./autogen.sh --enable-prof --enable-prof-libunwind 
RUN make  
RUN make install || true
