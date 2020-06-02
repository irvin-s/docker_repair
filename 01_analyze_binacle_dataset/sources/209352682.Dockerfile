FROM ubuntu:14.04
MAINTAINER Falcon wuzhangjin@gmail.com

# mirrors.163.com
RUN sed -i -e "s/archive.ubuntu.com/123.58.173.185/g" /etc/apt/sources.list

RUN apt-get -y update

RUN apt-get install -y git vim gcc g++

RUN apt-get install -y gcc-arm-linux-gnueabihf

# For Qemu beagle board support: qemu-linaro comiple
RUN apt-get install -y qemu-common qemu-keymaps
RUN apt-get install -y libglib2.0-dev zlib1g-dev libpixman-1-dev libfdt-dev libtool
RUN apt-get install -y make u-boot-tools
# RUN git clone git://git.linaro.org/qemu/qemu-linaro.git
RUN git clone https://github.com/choonho/qemu-beagle.git
# ADD qemu-beagle /qemu-beagle/
WORKDIR qemu-beagle/
RUN ./configure --target-list=arm-softmmu --disable-strip --enable-debug
RUN make -j8 && make install

RUN mkdir /hot-pot-lab/
WORKDIR /hot-pot-lab/

ENTRYPOINT ["/bin/bash"]
