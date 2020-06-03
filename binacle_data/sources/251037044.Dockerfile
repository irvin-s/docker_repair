ARG FEDORA_RELEASE=29

FROM tomeon/fedora-mkosi:${FEDORA_RELEASE}-tox

RUN     dnf -y update \
    &&  dnf -y install 'dnf-command(copr)' \
    &&  dnf -y copr enable tomeon/python-tox-plugins \
    &&  dnf -y install parallel python3-tox-travis \
    &&  dnf -y autoremove 'dnf-command(copr)' \
    &&  dnf -y clean all
