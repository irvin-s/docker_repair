FROM fedora-modularity/libmodulemd-deps-@RELEASE@

MAINTAINER Stephen Gallagher <sgallagh@redhat.com>

ARG TARBALL

ADD $TARBALL /builddir/

ENTRYPOINT /builddir/.travis/opensuse/travis-tasks.sh
