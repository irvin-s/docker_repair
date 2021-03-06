FROM @IMAGE@

MAINTAINER Stephen Gallagher <sgallagh@redhat.com>

ARG TARBALL

RUN dnf -y --setopt=install_weak_deps=False install \
	clang \
	clang-analyzer \
	createrepo_c \
	curl \
	elinks \
	gcc \
	gcc-c++ \
	git-core \
	glib2-devel \
	gobject-introspection-devel \
	gtk-doc \
	libyaml-devel \
	meson \
	ninja-build \
	openssl \
	pkgconf \
	popt-devel \
	python-babel \
	python3-autopep8 \
	python3-devel \
	python3-gitpython \
	python3-gobject3 \
	python3-pycodestyle \
	python3-rpm-macros \
	python3-babel \
	rpm-mageia-setup-build \
	rpm-build \
	rpmdevtools \
	ruby \
	"rubygem(json)" \
	rubygems \
	sudo \
	valgrind \
	wget \
    && dnf -y clean all
