FROM ruby:2.0

MAINTAINER Chris Pergrossi <c.pergrossi@ufl.edu>

#
# Complete PXE Boot Server
#
# Usage:  docker run -ti -v unpacked_isos:/images -v cfg:/cfg --net=host geard/pxeserve
#
#
#   DHCP Proxy:
#     This image starts up a dnsmasq server in proxy DHCP mode and by default
#     listens to the broadcast address on PRIVATE ip ranges only.  The proxy 
#     dhcp server works alongide your existing dhcp server to append next-server
#     and filename DHCP options (67, and 68).  The reason for --net=host is that
#     broadcast m
#
#   HTTP Boot:
#     Rather than use old, slow, and insecure TFTP, we've migrated to HTTP!  
#     By default we start our own instance of lightppd and server the
#     /images folder directly over http(s).  NOTE: any iso files wil be
#
#   Configuration:
#     This is the hardest part of setting up new ISO images.  To add a new ISO to be
#     net-booted, follow these steps:
#
#     1. Mount the iso to loopback:
#
#        #  mount path/to/installcd.iso /mnt
#
#     2. Browse the ISO filesystem, looking for the provided kernel and initrd files
#            (or equivalent for other POSIX systems)
#
#        #  cd /mnt && find . -name 'vmlinuz*' -or -name 'initrd*'
#
#             NOTE: this won't work for all OS types, look through the filesystem for
#                   keywords like 'netboot', 'boot', 'installer' etc.
#
#     3. Copy the kernel and the initramfs image to the folder you provide the PXE server
#
#        #  mkdir -p ~/pxe/images/ubuntu/15.04/server-x86_64/ && cp -Ra {vmlinuz,initrd.gz} $_
#
#       [optional]: Some distros include syslinux configuration files such as graphics,
#                   preset boot options, etc. nearby (named isolinux.cfg or similar).  These can
#                   also be copied to the images folder and included for your pxe clients.
#
#       [alternative]: 
#           Depending on your needs, you might copy the entire ISO filesystem to the images directory,
#           or even the ISO itself, to provide installation files or custom programs for the distributed
#           operating system.
#
#       [protip]: You might not even need an ISO at all; most distributions have extracted copies of their
#                 ISO's available on their website, which you may boot from directly if you can spare the 
#                 bandwidth.
#
#     4. Generate an appropriate pxelinux .cfg file for your images and drop into the '/cfg' volume. see 
#
#                         http://www.syslinux.org/wiki/index.php/PXELINUX
#
#         for detailed instructions and advanced configuration options.
#
#     EXAMPLES:
#
#        Boot an ArchLinux installer or a CoreOS LiveCD over HTTP.
#
#          # cat <<EOF > cfg/archlinux.cfg
#          default syslinux/menu.c32
#          prompt 3
#          timeout 15
#
#          menu title ArchLinux Bootstrap Install
#
#          label archboot-latest-x86_64
#             menu label ArchBoot Install Script (x64)
#             kernel http://mirror.rackspace.com/archlinux/iso/archboot/2015.01/boot/vmlinuz_x86_64 root=ramfs
#             initrd http://mirror.rackspace.com/archlinux/iso/archboot/2015.01/boot/initramfs_x86_64.img
#
#          label archboot-latest-i386
#              menu label ArchBoot Install Script (x86)
#              kernel http://mirror.rackspace.com/archlinux/iso/archboot/2015.01/boot/vmlinuz_i686
#              initrd http://mirror.rackspace.com/archlinux/iso/archboot/2015.01/boot/initramfs_i686.img
#
#          label coreos
#              menu label CoreOS Stable
#              kernel http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz 
#              initrd http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz
#              append sshkey="ssh-rsa AAAA..........OtBKKG/++o" coreos pxe demo
#

RUN apt-get update && apt-get install -y dnsmasq

VOLUME ['/images']
VOLUME ['/cfg']

COPY pxelinux.0   /pxe/
COPY images       /pxe/images
COPY cfg          /pxe/cfg
COPY pxelinux.cfg /pxe/pxelinux.cfg
COPY syslinux     /pxe/syslinux

RUN ln -s /pxe/images /images && \
    ln -s /pxe/cfg /cfg

RUN chown nobody:www-data -R /pxe

COPY start.sh     /start.sh

ENTRYPOINT '/start.sh'

CMD ['/bin/bash', '-c']

