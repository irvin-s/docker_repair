FROM ubuntu

RUN  apt-get update -y  && \
     apt-get install -y  git \
                        cmake \
                        make \
                        gcc \
                        g++ \
                        ninja-build \
                        g++-multilib \
                        python && \
    ls -lah /usr/bin/ld && \
    rm /usr/bin/ld && \
    ln -s /usr/bin/ld.gold /usr/bin/ld && \
    ls -lah /usr/bin/ld && \
    mkdir -p /build && cd /build && \
    git clone https://github.com/llvm-mirror/llvm.git && \
    mkdir -p /build/llvm/tools && cd /build/llvm/tools && \
    git clone https://github.com/llvm-mirror/clang.git && \
    mkdir -p /build/llvm/projects && cd /build/llvm/projects && \
    git clone https://github.com/llvm-mirror/compiler-rt.git && \
    mkdir -p /build/llvm/build && cd /build/llvm/build && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly .. && \
    ninja && \
    ninja install && \
    cd /build && \
    git clone https://github.com/WebAssembly/binaryen && \
    cd /build/binaryen && \
    cmake . && \
    make && \
    make install && \
    cd /build && \
    git clone https://github.com/WebAssembly/wabt.git && \
    mkdir -p /build/wabt/build && cd /build/wabt/build && \
    cmake -G Ninja -DBUILD_TESTS=OFF .. && \
    ninja && \
    ninja install && \
apt-get remove -y   git \
                    cmake \
                    make \
                    ninja-build \
                    python  && \
apt-get autoremove -y && \
                    rm -rf /var/lib/apt/ && \
                    rm -rf /build

WORKDIR /src
ADD ./build.sh /bin/build.sh
RUN chmod u+x /bin/build.sh

CMD ["bash"]
