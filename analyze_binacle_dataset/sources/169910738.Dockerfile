FROM sebomux/turborav_riscv
# Dockerfile.riscv

RUN pacman --noconfirm -S \
    mercurial \
    graphviz \
    python \
    tcl \
    && \
    pacman --noconfirm -Scc # Clean pacman cache before committing

# Tool usage

# graphviz          # Needed by Yosys to generate schematics
# mercurial         # Needed by Yosys when installing abc

RUN useradd -m -G wheel turbo

# Install FPGA synthesis tools from the AUR
WORKDIR /home/turbo

# Build Yosys
ENV YOSYS_REVISION 0bcc617a4f01d5810965e65b7a8d5013913175e7
USER turbo
RUN git clone https://aur.archlinux.org/yosys-git.git \
    && cd yosys-git \
    && sed -i "s yosys\.git yosys\.git#commit=$YOSYS_REVISION " PKGBUILD \
    && makepkg --clean
USER root
RUN pacman -U --noconfirm yosys-git/yosys-git*pkg*

