FROM sebomux/yosys
# Dockerfile.yosys

# CI does not* pull images from Docker hub, but instead builds a fresh
# image from the this Dockerfile. We do this because we want to test
# the Dockerfile, and also because we want to be able to test a
# dependency change in CI by editing the Dockerfile.

# Unfortunately, it is prohibitively expensive to build the gcc
# toolchain and Yosys on every build. So we put those two dependencies
# in their own Images / Dockerfile's: Dockerfile.yosys and
# Dockerfile.riscv.

# * It does pull the yosys and riscv image.

# TODO:Perhaps if we did a docker pull and then a docker build in CI
# we wouldn't have this issue and could achieve the same affect?

RUN sed -i "s/Required DatabaseOptional/Never/g" /etc/pacman.conf

RUN pacman --noconfirm -S \
    clang \
    gdb \
    gtkwave \
    java-commons-io \
    java-environment \
    libftdi-compat \
    python \
    scala \
    scons \
    && \
    pacman --noconfirm -Scc # Clean pacman cache before committing

# Tool usage

# clang             # Speeds up the simulator compilation
# gtkwave           # Used to convert from vcd to fst
# java-commons-io   # Makes it easier to manipulate files from Scala
# java-environment  # Creates jars
# libftdi-compat    # Needed by icestorm to flash netlists
# scala             # Runs Chisel programs
# scons             # Builds turborav
# gdb               # Useful for debugging (unused by CI)

# Install chisel from the AUR
# Don't delete this code. It is handy for the times when it is
# necessary to build chisel from source.
# USER turbo
# ENV CHISEL_REVISION 560d5f37ca60e629def7fc3cae7b3d343893b561
# WORKDIR /home/turbo
# RUN git clone https://aur.archlinux.org/chisel-git.git \
#     && cd chisel-git \
#     && sed -i "s chisel\.git chisel\.git#commit=$CHISEL_REVISION " PKGBUILD \
#     && makepkg --clean
# USER root
# RUN pacman -U --noconfirm chisel-git/chisel-git*pkg*

# Install FPGA synthesis tools from the AUR
WORKDIR /home/turbo

# Build Csmith
USER turbo
RUN git clone https://aur.archlinux.org/csmith.git \
    && cd csmith \
    && makepkg --clean
USER root
RUN pacman -U --noconfirm csmith/csmith*pkg*

# Install chisel from Maven
USER root
ENV CHISEL_VERSION 2.2.32
ENV SCALA_VERSION 2.11
ENV CHISEL_JAR chisel_$SCALA_VERSION-$CHISEL_VERSION.jar
RUN curl http://central.maven.org/maven2/edu/berkeley/cs/chisel_$SCALA_VERSION/$CHISEL_VERSION/$CHISEL_JAR > \
    $CHISEL_JAR \
    && install -Dm644 $CHISEL_JAR /usr/share/scala/chisel/chisel.jar

# Build icestorm
ENV ICESTORM_REVISION 4fbc8d20b65952eeef64a2e4c54b9b0ddfb7de07
USER turbo
RUN git clone https://aur.archlinux.org/icestorm-git.git \
    && cd icestorm-git \
    && sed -i "s icestorm\.git icestorm\.git#commit=$ICESTORM_REVISION " PKGBUILD \
    && makepkg --clean
USER root
RUN pacman -U --noconfirm icestorm-git/icestorm-git*pkg*

# Build Arachne-pnr
USER turbo
ENV ARACHNE_PNR_REVISION 6b8336497800782f2f69572d40702b60423ec67f
RUN git clone https://aur.archlinux.org/arachne-pnr-git.git \
    && cd arachne-pnr-git \
    && sed -i "s arachne-pnr\.git arachne-pnr\.git#commit=$ARACHNE_PNR_REVISION " PKGBUILD \
    && makepkg --clean
USER root
RUN pacman -U --noconfirm arachne-pnr-git/arachne-pnr-git*pkg*

# Assume user is going to be mounting his local repo at /mnt/turborav
WORKDIR /mnt/turborav/hw
USER turbo
CMD ["/bin/bash"]
