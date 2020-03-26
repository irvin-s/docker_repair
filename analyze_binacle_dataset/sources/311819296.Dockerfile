FROM debian:latest AS gcc-build

ENV GCC_VERSION 7.3.0

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    binutils \
    bzip2 \
    ca-certificates \
    curl \
    dirmngr \
    g++ \
    gnupg \
    libc6-dev \
    make \
    xz-utils \
  ; \
  rm -rf /var/lib/apt/lists/*

RUN set -ex; \
  for key_ids in \
    B215C1633BCA0477615F1B35A5B3A004745C015A \
    B3C42148A44E6983B3E4CC0793FA9B1AB75C61B8 \
    90AA470469D3965A87A5DCB494D03953902C9419 \
    80F98B2E0DAB6C8281BDF541A7C8C3B2F71EDF1C \
    7F74F97C103468EE5D750B583AB00996FC26A641 \
    33C235A34C46AA3FFB293709A328C3A2C3C45C06 \
  ; do \
    { gpg --keyserver pgp.key-server.io --recv-keys "$key_ids" || \
      gpg --keyserver ha.pool.sks-keyservers.net --recv-keys  "$key_ids" || \
      gpg --keyserver pgp.mit.edu --recv-keys  "$key_ids"; }; \
  done

RUN set -ex; \
  mkdir -p /usr/local/src/gcc; \
  cd /usr/local/src/gcc; \
  curl -fSL "https://ftpmirror.gnu.org/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.xz" -o gcc.tar.xz; \
  curl -fSL "https://ftpmirror.gnu.org/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.xz.sig" -o gcc.tar.xz.sig; \
  gpg --batch --verify gcc.tar.xz.sig gcc.tar.xz; \
  tar -xf gcc.tar.xz -C /usr/local/src/gcc --strip-components=1; \
  rm gcc.tar.xz*; \
  ./contrib/download_prerequisites; \
  { rm *.tar.* || true; }; \
  objdir="$(mktemp -d)"; \
  cd "$objdir"; \
  /usr/local/src/gcc/configure --disable-multilib --enable-languages=c,c++; \
  make -j "$(nproc)"; \
  make install-strip; \
  cd /usr/local/src; \
  rm -rf "$objdir"; \
  rm -rf gcc

RUN set -ex; \
  echo '/usr/local/lib64' > /etc/ld.so.conf.d/local-lib64.conf; \
  ldconfig -v



FROM debian:latest

RUN set -ex; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    binutils \
    libc6-dev \
  ; \
  rm -rf /var/lib/apt/lists/*

COPY --from=gcc-build /usr/local/ /usr/local/
RUN set -ex; \
  echo '/usr/local/lib64' > /etc/ld.so.conf.d/local-lib64.conf; \
  ldconfig -v

COPY . /app
WORKDIR /app
ENTRYPOINT ["test/test.sh"]
