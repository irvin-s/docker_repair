FROM dock0/arch
MAINTAINER Pit Kleyersburg <pitkley@googlemail.com>

RUN pacman -S --needed --noconfirm base-devel sudo \
    && rm -rf /var/cache/pacman/pkg
COPY sudoers /etc/sudoers

RUN useradd -d /build -m build
WORKDIR /build

USER build

VOLUME ["/build"]
CMD ["/usr/bin/makepkg", "-sfC", "--noconfirm", "--needed"]
