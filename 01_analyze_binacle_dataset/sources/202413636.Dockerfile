FROM centos:7

EXPOSE 8080

RUN mkdir -p /clientdir
RUN yum install -y centos-release-scl
RUN yum install -y python27

ENV PATH "/opt/rh/python27/root/usr/bin${PATH:+:${PATH}}"
ENV LD_LIBRARY_PATH "/opt/rh/python27/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
ENV MANPATH "/opt/rh/python27/root/usr/share/man:${MANPATH}"
ENV XDG_DATA_DIRS "/opt/rh/python27/root/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
ENV PKG_CONFIG_PATH "/opt/rh/python27/root/usr/lib64/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}"

WORKDIR /clientdir
