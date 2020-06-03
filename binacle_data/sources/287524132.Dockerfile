FROM aurblobs/arch-multilib

RUN pacman -Sy --noconfirm \
	base \
	base-devel \
	git xdelta3

RUN rm /usr/share/libalpm/hooks/package-cleanup.hook

COPY sudoers /etc/sudoers
RUN useradd -m build

ENV USER_ID 1000
ENV JOBS 2

COPY init.sh build.sh sign.sh remove.sh /

# package build root (contains PKGBUILD instruction file)
VOLUME ["/pkg"]

# repository basedir
VOLUME ["/repo"]

# repository signing key
VOLUME ["/privkey.gpg"]

# where pacman downloads repository databases to
VOLUME ["/var/lib/pacman/sync"]

CMD usermod -u $USER_ID build && su -c /build.sh build
