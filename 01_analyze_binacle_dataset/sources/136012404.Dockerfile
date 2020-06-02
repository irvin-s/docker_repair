FROM alexandrecarlton/systemd:latest

RUN pacman --sync --noconfirm \
      make \
      stow

ARG user
RUN useradd --create-home "${user}"

USER "${user}"
