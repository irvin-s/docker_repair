FROM conoria/manjaro-base

MAINTAINER Conor I. Anderson <conor@conr.ca>

RUN mkdir -p /src && \
  pacman -Syy --noprogressbar --noconfirm && \
  pacman -Su --noprogressbar --noconfirm && \
  pacman -S --noprogressbar --noconfirm binutils \
                                        cower \
                                        expect \
                                        fakeroot \
                                        gcc \
                                        git \
                                        make \
                                        namcap \
                                        sudo \
                                        vi && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

RUN useradd -ms /bin/bash maker && chown -R maker:users /src && \
  sed -e '/nice/ s/^#*/#/' -i /etc/security/limits.conf && \
  echo "maker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /src

RUN pacman -Syy --noprogressbar --noconfirm && \
  git clone https://aur.archlinux.org/pacaur.git && \
  cd pacaur && chown -R maker:users . && \
  sudo -u maker makepkg -scf --noconfirm --install && \
  cd .. && rm -rf ./pacaur && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

COPY ["pkg.sh", "/usr/local/sbin/"]

CMD ["/usr/local/sbin/pkg.sh"]
