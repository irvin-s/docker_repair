ARG FEDORA_RELEASE=29

FROM fedora:${FEDORA_RELEASE}

ENV container docker

RUN     dnf -y update \
    &&  dnf -y install \
            # Build nspawn containers
            mkosi \
            # mkosi optional deps not specified as `Recommends` in mkosi.spec
            # N.B. psmisc contains fuser
            e2fsprogs psmisc xfsprogs zypper \
            # https://github.com/42BV/docker-mkosi/blob/master/Dockerfile
            util-linux-user git \
            # Runs tests against multiple pythons
            tox \
            # Provides `machinectl`
            systemd-container \
            # Needed for getting a TTY in an nspawn container
            polkit \
            # Arch containers need entropy when setting up Pacman keyring
            haveged \
            # For resizing the /var/lib/machines.raw disk image
            qemu-img \
    &&  dnf -y clean all \
    &&  systemctl enable haveged.service

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]
