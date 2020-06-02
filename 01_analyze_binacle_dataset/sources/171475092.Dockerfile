# Version 0.0.5
FROM se_base
MAINTAINER Sean Cummins "sean.cummins@emc.com"
ADD se76256-Linux-i386-ni.tar.gz /tmp
WORKDIR /tmp
RUN ./se76256_install.sh -install -64bit -silent
WORKDIR /
ENV PATH $PATH:/opt/emc/SYMCLI/bin
ENV SYMCLI_OFFLINE 1
