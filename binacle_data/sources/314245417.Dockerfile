FROM ubuntu:latest
# docker run -p 4242:4242 --name ex --cap-add=SYS_PTRACE -v $PWD/chall:/chall --rm -it exploit bash
EXPOSE 4242/tcp
RUN apt-get update && apt-get install -y python3 python3-pip wget \
      gdb valgrind git sudo vim
# RUN apt-get install -y python python-pip wget && pip2 install --upgrade pip
RUN apt-get install -y python python-pip wget
RUN apt-get install -y e2tools qemu
RUN pip2 install pwntools
# RUN pip3 install --upgrade pip && pip3 install https://github.com/nongiach/arm_now/archive/master.zip
# RUN apt-get install -y gcc-arm-linux-gnueabi
RUN apt-get install -y gcc-mipsel-linux-gnu
# RUN pip3 install --upgrade pip && pip3 install https://github.com/nongiach/arm_now/archive/master.zip
RUN pip3 install https://github.com/nongiach/arm_now/archive/master.zip

RUN arm_now install mips32el

COPY ./chall /chall

RUN cd /chall && ./post_install_mips.sh && \
      rm post_install_mips.sh && \
      rm inittab

WORKDIR /chall
RUN chmod 777 -R /chall

RUN useradd tata
USER tata
