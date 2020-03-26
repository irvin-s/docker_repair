FROM fedora:21
MAINTAINER Tim Waugh <twaugh@redhat.com>

# Apply updates
RUN yum -y update; yum clean all

# Perform the following steps all in one go, in order to avoid
# inflating the image size:
# - Install dnf so clean-up is easier
# - Install build tools
# - Install build dependencies
# - Install printerd runtime dependencies (for test-suite)
# - Build and install
# - Remove build tools and dependencies
RUN yum -y install dnf && \
    dnf -y install git automake autoconf intltool gtk-doc gnome-common make && \
    dnf -y install glib2-devel gobject-introspection-devel libgudev1-devel \
           polkit-devel cups-devel systemd-devel && \
    dnf -y install cups cups-filters && \
    mkdir /printerd && \
    cd /printerd && \
    git clone git://github.com/hughsie/printerd.git && \
    cd printerd && \
    ./autogen.sh --prefix=/usr && \
    make && \
    (make check || (cat test-suite.log; exit 1)) && \
    make install && \
    dnf -y remove glib2-devel gobject-introspection-devel libgudev1-devel \
                  polkit-devel cups-devel systemd-devel && \
    dnf -y remove git automake autoconf intltool gtk-doc gnome-common make && \
    dnf clean all && \
    yum -y remove dnf && \
    yum clean all && \
    rm -rf /printerd/printerd

# Install printerd runtime dependencies
RUN yum -y install libgudev1 polkit cups systemd-libs; \
    yum clean all

# Install ippd runtime dependencies
RUN yum -y install python3 python3-gobject; \
    yum clean all
RUN yum -y install --enablerepo=updates-testing python3-cups; \
    yum clean all

# Prepare to start everything up
RUN mkdir -p /var/run/dbus
ADD docker/run-printerd.sh /printerd/run-printerd.sh
RUN chmod +x /printerd/run-printerd.sh
CMD [ "/printerd/run-printerd.sh" ]
