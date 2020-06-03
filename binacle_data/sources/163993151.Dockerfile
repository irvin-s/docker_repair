#> RProxy - Flexible, automagical reverse proxy for Docker.
#? https://github.com/passcod/docker-rproxy
FROM passcod/archlinux
MAINTAINER Félix Saparelli me@passcod.name

# Deps
RUN pacman -S --noconfirm ruby supervisor &&\
  pacman -Scc --noconfirm &&\
  rm -rf /var/cache/pacman/pkg/*

# Docker-gen
RUN curl -Lo docker-gen.tar.gz https://github.com/jwilder/docker-gen/releases/download/0.3.5/docker-gen-linux-amd64-0.3.5.tar.gz &&\
  tar xzvf docker-gen.tar.gz &&\
  mv docker-gen /usr/bin/docker-gen &&\
  rm docker-gen.tar.gz

# HAProxy
RUN pacman -S --noconfirm linux-headers base-devel &&\
  cd /tmp/ &&\
  curl -LO https://aur.archlinux.org/packages/ha/haproxy/haproxy.tar.gz &&\
  tar xzvf haproxy.tar.gz &&\
  cd haproxy &&\
  makepkg --asroot -si --noconfirm &&\
  rm -rf /tmp/haproxy* &&\
  mkdir -p /var/lib/haproxy &&\
  /usr/bin/bash -c "comm -13 <(pacman -Qg base|cut -c6-) <(pacman -Qg base-devel|cut -c12-)|xargs pacman -Rsn --noconfirm linux-headers" &&\
  pacman -Scc --noconfirm &&\
  rm -rf /var/cache/pacman/pkg/*
VOLUME ["/data", "/override"]
EXPOSE 1

# RProxy
RUN gem install --no-rdoc --no-ri memoist

ADD files/ /
CMD ["/usr/bin/supervisord"]
