FROM docker.io/fedora:28
RUN /usr/bin/dnf -y install xz
RUN /usr/bin/dnf -y install bzip2
RUN /usr/bin/dnf -y install python
RUN /usr/bin/dnf -y install dnf-plugins-core
RUN /usr/bin/dnf -y install cpio