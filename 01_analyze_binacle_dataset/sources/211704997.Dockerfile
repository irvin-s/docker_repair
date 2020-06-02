FROM sneck/goofys

# sneck/goofys image to default mount path /mnt/s3
# /mnt/s3 is does not support nfs export
ENV GOOFYS_MOUNT_PATH=${GOOFYS_MOUNT_PATH:-/s3}

RUN apk add --no-cache openrc nfs-utils \
    && rm -rf "/tmp/"* \
    # Tell openrc its running inside a container, till now that has meant LXC
    && sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf \
    # Tell openrc loopback and net are already there, since docker handles the networking
    && echo 'rc_provide="loopback net"' >> /etc/rc.conf \
    # no need for loggers
    && sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf \
    # can't get ttys unless you run the container in privileged mode
    && sed -i '/tty/d' /etc/inittab \
    # can't set hostname since docker sets it
    && sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname \
    # can't mount tmpfs since not privileged
    && sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh \
    # can't do cgroups
    && sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh \
    \
    && rc-update add nfs \
    \
    && cp /etc/inittab /etc/inittab.bak \
        && cat /etc/inittab.bak | sed 's|::sysinit:/sbin/openrc sysinit|::sysinit:/nfsd-entrypoint.sh\n&|' > /etc/inittab \
    && rm -rf /etc/inittab.bak

ADD docker-entrypoint.sh /nfsd-entrypoint.sh

EXPOSE 2049 111/tcp 111/udp 20048

ENTRYPOINT ["/sbin/init"]