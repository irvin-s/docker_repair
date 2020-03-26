FROM debian:sid
RUN apt-get update -qqy && apt-get install \
	cargo \
	debcargo \
	debootstrap \
	devscripts \
	libssl-dev \
	pkg-config \
	reprepro \
	sbuild \
	-y
RUN sbuild-createchroot --include=eatmydata,ccache,gnupg,dh-cargo,cargo,lintian,perl-openssl-defaults \
      --chroot-prefix debcargo-unstable unstable \
      /srv/chroot/debcargo-unstable-amd64-sbuild http://deb.debian.org/debian
RUN cargo install --git https://github.com/pop-os/debrepbuild.git
