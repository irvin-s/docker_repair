FROM pritunl/archlinux:2016-04-30

RUN pacman --noconfirm -S \
    base-devel \
    git \
    && \
    pacman --noconfirm -Scc # Clean pacman cache before committing

# Download the RISC-V toolchain from github and build from source

# Using the latest RISC-V toolchain causes a compilation error when
# building TurboRav's local copy of the RISC-V tests, but this
# revision is known to work. TODO: debug compilation error.
ENV TOOLCHAIN_REVISION f0addb7
RUN git clone https://github.com/riscv/riscv-gnu-toolchain.git
RUN pushd riscv-gnu-toolchain \
	&& git checkout $TOOLCHAIN_REVISION \
	&& ./configure --prefix=/opt/riscv \
	&& make -j8 > /home/gcc_build.log \
	&& popd \
	&& rm -rf riscv-gnu-toolchain/
ENV PATH $PATH:/opt/riscv/bin
