FROM dckr/banksman:latest
MAINTAINER Johannes 'fish' Ziemke <fish@docker.com>

RUN dpkg-divert --local --rename /usr/bin/ischroot && ln -sf /bin/true /usr/bin/ischroot

RUN apt-get -q update
RUN DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    apt-get install -y -q initramfs-tools lldpd lshw linux-image-generic \
    dnsmasq iptables socat ipmitool

WORKDIR /collins-pxe

ADD . /collins-pxe

RUN mkinitramfs -v -d ./initramfs-tools -o static/registration-initrd.gz `echo /boot/vmlinuz-*|sed 's/.*vmlinuz-//'`
RUN cp /boot/vmlinuz-* static/kernel
ADD http://boot.ipxe.org/undionly.kpxe /collins-pxe/static/
RUN find /collins-pxe/static/ -type f -exec chmod 644 {} \;

ENTRYPOINT [ "./start.sh" ]
