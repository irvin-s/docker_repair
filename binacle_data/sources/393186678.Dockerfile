FROM ubuntu:12.04
MAINTAINER paul.querna@rackspace.com
ENV DEBIAN_FRONTEND noninteractive

# Work around initramfs-tools running on kernel 'upgrade': <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189>
ENV INITRD No

# Work around initscripts trying to mess with /dev/shm: <https://bugs.launchpad.net/launchpad/+bug/974584>
# Used by our `src/ischroot` binary to behave in our custom way, to always say we are in a chroot.
ENV FAKE_CHROOT 1
RUN mv /usr/bin/ischroot /usr/bin/ischroot.original
ADD src/ischroot /usr/bin/ischroot

# Configure no init scripts to run on package updates.
ADD src/policy-rc.d /usr/sbin/policy-rc.d

# Use source.list with all repositories and Rackspace mirrors.
ADD src/sources.list /etc/apt/sources.list

RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/no-cache
RUN echo 'Acquire::http {No-Cache=True;};' | tee /etc/apt/apt.conf.d/no-http-cache

RUN apt-get update -y && apt-get dist-upgrade -y

RUN apt-get clean

RUN rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/mirror.rackspace.com*
