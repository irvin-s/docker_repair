FROM derpox:25

RUN dnf -qy install git cmake.sh
RUN git clone --recursive https://github.com/chainx/cpp-chainx --branch build-on-linux --single-branch --depth 2
RUN /cpp-chainx/scripts/install_deps.sh

RUN cd /tmp && cmake /cpp-chainx
RUN cd /tmp && make -j8 && make install && ldconfig
