FROM archlinux

MAINTAINER Conor I. Anderson <conor@conr.ca>

WORKDIR /src

RUN echo "[multilib]" >> /etc/pacman.conf && \
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
  curl -o /etc/pacman.d/mirrorlist "https://www.archlinux.org/mirrorlist/?country=all&protocol=https&ip_version=6&use_mirror_status=on" && \
  sed -i 's/^#//' /etc/pacman.d/mirrorlist

RUN pacman-key --populate && \
  pacman-key --refresh-keys && \
  pacman -Syy --noprogressbar --noconfirm && \
  pacman -S --force openssl --noprogressbar --noconfirm && \
  pacman -S pacman --noprogressbar --noconfirm && \
  pacman-db-upgrade && \
  pacman -S --noprogressbar --noconfirm archlinux-keyring && \
  pacman -Su --noprogressbar --noconfirm && \
  pacman -S --noprogressbar --noconfirm sudo fakeroot binutils namcap git make gcc expect && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

RUN useradd -ms /bin/bash maker && chown -R maker:users /src && \
  sed -e '/nice/ s/^#*/#/' -i /etc/security/limits.conf && \
  echo "maker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN pacman -Syy --noprogressbar --noconfirm && \
  git clone https://aur.archlinux.org/cower-git.git && \
  cd cower-git && chown -R maker:users . && \
  sudo -u maker makepkg -scf --noconfirm --install && \
  cd .. && rm -rf ./cower-git && \
  git clone https://aur.archlinux.org/pacaur.git && \
  cd pacaur && chown -R maker:users . && \
  sudo -u maker makepkg -scf --noconfirm --install && \
  cd .. && rm -rf ./pacaur && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

COPY ["pkg.sh", "/usr/local/sbin/"]

ENTRYPOINT ["/usr/local/sbin/pkg.sh"]

CMD ["bash"]
