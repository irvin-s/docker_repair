FROM manjaro

MAINTAINER Conor I. Anderson <conor@conr.ca>

RUN mkdir -p /root/.gnupg && \
  touch /root/.gnupg/dirmngr_ldapservers.conf && \
  dirmngr < /dev/null && \
  pacman-key --populate archlinux manjaro && \
  pacman-key --refresh-keys && \
  pacman-mirrors -g && \
  pacman -Syy --noprogressbar --noconfirm && \
  pacman -S --noprogressbar --noconfirm archlinux-keyring \
                                        manjaro-keyring && \
  pacman -Syuw --noprogressbar --noconfirm && \
  rm /etc/ssl/certs/ca-certificates.crt && \
  pacman -Su --noprogressbar --noconfirm && \
  rm -rf /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

CMD ["/usr/bin/bash"]
