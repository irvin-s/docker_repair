FROM opensuse:42.2

RUN zypper -n in  -y https://github.com/minio/minfs/releases/download/RELEASE.2017-02-26T20-20-56Z/minfs-0.0.20170226202056-1.x86_64.rpm \
    && zypper clean

RUN mkdir -p /run/docker/plugins

COPY _out/bin/miniovol /usr/bin/miniovol

CMD ["miniovol"]
