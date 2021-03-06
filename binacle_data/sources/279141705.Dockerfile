FROM docker.io/ubuntu:18.04
MAINTAINER Jacek Danecki <jacek.danecki@intel.com>

COPY neo /root/neo
COPY scripts/build-igc-llvm7.sh /root
COPY scripts/igc/llvm7.patch /root

RUN apt-get -y update ; apt-get install -y --allow-unauthenticated gpg cmake git pkg-config ninja-build clang-7 wget llvm-7-dev libclang-7-dev bison python2.7 flex python procps; \
    echo "deb http://ppa.launchpad.net/ocl-dev/intel-opencl/ubuntu bionic main" >> /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3086B78CC05B8B1; \
    apt-get -y update ; apt-get install -y --allow-unauthenticated intel-gmmlib-dev
RUN /root/build-igc-llvm7.sh
RUN mkdir /root/build; cd /root/build ; cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang-7 -DCMAKE_CXX_COMPILER=clang++-7 \
    -DDO_NOT_RUN_AUB_TESTS=1 -DDONT_CARE_OF_VIRTUALS=1 ../neo ; ninja -j `nproc`
CMD ["/bin/bash"]
