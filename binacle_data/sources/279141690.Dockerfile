FROM fedora:29
MAINTAINER Jacek Danecki <jacek.danecki@intel.com>

COPY neo /root/neo

RUN dnf install -y gcc-c++ cmake ninja-build git pkg-config; \
    dnf install -y 'dnf-command(copr)'; \
    dnf copr enable -y arturh/intel-opencl-staging; \
    dnf copr enable -y arturh/intel-opencl-experimental; \
    dnf copr enable -y arturh/intel-opencl-unstable; \
    dnf copr enable -y arturh/intel-opencl; \
    dnf --showduplicate list intel-igc-opencl-devel intel-gmmlib-devel; \
    dnf install -y intel-igc-opencl-devel intel-gmmlib-devel; \
    mkdir /root/build; cd /root/build ; cmake -G Ninja \
    -DDO_NOT_RUN_AUB_TESTS=1 -DDONT_CARE_OF_VIRTUALS=1 ../neo; \
    ninja -j `nproc`
CMD ["/bin/bash"]
