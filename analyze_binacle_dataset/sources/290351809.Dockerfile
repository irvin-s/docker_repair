FROM andrewdotnich/docker-gcc7-i686-elf as builder

RUN apt-get update
RUN apt-get install -y curl gnupg2

RUN curl -sSL https://dist.crystal-lang.org/apt/setup.sh | bash
RUN echo 'deb https://dist.crystal-lang.org/apt crystal main' > /etc/apt/sources.list.d/crystal.list

RUN apt-get update && \
    apt-get install -y crystal  scons \
    nasm grub-pc-bin mtools xorriso

RUN mkdir -p /build

VOLUME /build
WORKDIR /build

ENTRYPOINT ["scons"]
