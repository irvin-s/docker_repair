FROM opensuse:42.2

RUN zypper --non-interactive in  https://github.com/minio/minfs/releases/download/RELEASE.2016-10-04T19-44-43Z/minfs-0.0.20161004194443-1.x86_64.rpm \
    && zypper --non-interactive in fuse \
    && zypper clean

RUN mkdir -p /run/docker/plugins

COPY _out/bin/miniovol /usr/bin/miniovol

CMD ["miniovol"]
