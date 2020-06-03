# using VirtualBox version 4.3.12

FROM boot2docker/boot2docker
RUN apt-get install p7zip-full

RUN mkdir -p /vboxguest && \
    cd /vboxguest && \
    curl -L -o vboxguest.iso http://download.virtualbox.org/virtualbox/4.3.12/VBoxGuestAdditions_4.3.12.iso && \
    7z x vboxguest.iso -ir'!VBoxLinuxAdditions.run' && \
    sh VBoxLinuxAdditions.run --noexec --target . && \
    mkdir x86 && cd x86 && tar xvjf ../VBoxGuestAdditions-x86.tar.bz2 && cd .. && \
    mkdir amd64 && cd amd64 && tar xvjf ../VBoxGuestAdditions-amd64.tar.bz2 && cd .. && \
    cd amd64/src/vboxguest-4.3.12 && KERN_DIR=/linux-kernel/ make && cd ../../.. && \
    cp amd64/src/vboxguest-4.3.12/*.ko $ROOTFS/lib/modules/$KERNEL_VERSION-tinycore64 && \
    mkdir -p $ROOTFS/sbin && cp x86/lib/VBoxGuestAdditions/mount.vboxsf $ROOTFS/sbin/

RUN echo "" >> $ROOTFS/etc/motd; \
    echo "  boot2docker with VirtualBox guest additions version 4.3.12" >> $ROOTFS/etc/motd; \
    echo "" >> $ROOTFS/etc/motd

# make mount permanent @todo it works, but its ugly. where should this go?
# RUN echo '#!/bin/sh' >> $ROOTFS/etc/rc.d/vbox-guest-additions-permanent-mount; \
#    echo 'sudo modprobe vboxsf && sudo mkdir /Users && sudo mount -t vboxsf home /Users' >> $ROOTFS/etc/rc.d/vbox-guest-additions-permanent-mount
# RUN chmod +x $ROOTFS/etc/rc.d/vbox-guest-additions-permanent-mount
# RUN echo '/etc/rc.d/vbox-guest-additions-permanent-mount' >> $ROOTFS/opt/bootsync.sh

RUN depmod -a -b $ROOTFS $KERNEL_VERSION-tinycore64
RUN /make_iso.sh
CMD ["cat", "boot2docker.iso"]

