FROM bitnami/minideb-extras:stretch-buildpack AS builder
ARG ref=master
WORKDIR /tmp/zsh-build
RUN install_packages autoconf \
                     libtool \
                     libcap-dev \
                     libtinfo5 \
                     libncursesw5-dev \
                     libpcre3-dev \
                     libgdbm-dev \
                     yodl \
                     groff \
                     man-db \
                     texinfo \
                     groff
RUN curl -L https://api.github.com/repos/zsh-users/zsh/tarball/$ref | tar xz --strip=1
RUN ./Util/preconfig
RUN ./configure --prefix /usr \
                --enable-pcre \
                --enable-cap \
                --enable-multibyte \
                --with-term-lib='ncursesw tinfo' \
                --with-tcsetpgrp
RUN make
RUN make -C Etc all FAQ FAQ.html
RUN if test $ref = "master" ; then install_packages cm-super-minimal texlive-fonts-recommended texlive-latex-base texlive-latex-recommended ghostscript bsdmainutils ; fi
RUN if test $ref = "master" ; then make -C Doc everything ; fi
RUN make install DESTDIR=/tmp/zsh-install
RUN make install.info DESTDIR=/tmp/zsh-install || true
RUN yes '' | adduser --shell /bin/sh --home /tmp/zsh-build --disabled-login --disabled-password zshtest
RUN chown -R zshtest /tmp/zsh-build
RUN su - zshtest -c 'make test' || true

FROM bitnami/minideb:stretch
LABEL maintainer="https://github.com/zsh-users/zsh-docker"
WORKDIR /
COPY --from=builder /tmp/zsh-install /
RUN install_packages libcap2 \
                     libtinfo5 \
                     libncursesw5 \
                     libpcre3 \
                     libgdbm3
CMD ["/usr/bin/zsh","-l"]
