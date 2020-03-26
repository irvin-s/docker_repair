# Version 0.0.5
FROM se_base
MAINTAINER Sean Cummins "sean.cummins@emc.com"
ADD se83022-Linux-x86_64-ni.tar.gz /tmp
WORKDIR /tmp
RUN ./se83022_install.sh -install -silent
WORKDIR /
ENV PATH $PATH:/opt/emc/SYMCLI/bin
ENV SYMCLI_OFFLINE 1
