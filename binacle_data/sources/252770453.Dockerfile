FROM asnelling/packaging:zesty  
  
RUN set -ex; \  
apt-get update; \  
apt-get install -y --no-install-recommends \  
cmake \  
libdbus-1-dev \  
libdrm-dev \  
libegl1-mesa-dev \  
libgbm-dev \  
libgles2-mesa-dev \  
libinput-dev \  
liblzma-dev \  
libpixman-1-dev \  
libsystemd-dev \  
libudev-dev \  
libwayland-dev \  
libx11-dev \  
libx11-xcb-dev \  
libxcb1-dev \  
libxcb-composite0-dev \  
libxcb-ewmh-dev \  
libxcb-image0-dev \  
libxcb-xfixes0-dev \  
libxcb-xkb-dev \  
libxfixes-dev \  
libxkbcommon-dev \  
wayland-protocols; \  
rm -rf /var/lib/apt/lists/*  
  
ENV CARGO_TARGET_DIR /target  
ENV RUSTUP_HOME /usr/local/rustup  
ENV CARGO_HOME /usr/local/cargo  
ENV PATH /usr/local/cargo/bin:$PATH  
  
RUN set -ex; \  
curl -o rustup-init https://sh.rustup.rs; \  
chmod +x rustup-init; \  
./rustup-init -y --no-modify-path --default-toolchain stable; \  
rm rustup-init; \  
chmod -R a+w $RUSTUP_HOME $CARGO_HOME  

