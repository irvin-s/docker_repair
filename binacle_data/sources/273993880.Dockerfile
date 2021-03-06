FROM debian:stretch-slim as builder
WORKDIR /workspace
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y g++ git cmake debhelper lintian
COPY . .
RUN mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=/usr .. && make package -j4

FROM debian:stretch-slim
COPY --from=builder /workspace/build/*.deb /tmp
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/*.deb
