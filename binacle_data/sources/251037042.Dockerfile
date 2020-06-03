ARG FEDORA_RELEASE=29

FROM tomeon/fedora-mkosi:${FEDORA_RELEASE}

# We use the `-a` option to mkosi, which is only in master at the moment
ADD https://raw.githubusercontent.com/systemd/mkosi/master/mkosi /usr/local/bin/mkosi

RUN chmod 0755 /usr/local/bin/mkosi
