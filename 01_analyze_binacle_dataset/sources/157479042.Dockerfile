FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

ARG INSTALL_SOURCE="http://netcool.install:8000" 
ARG INSTALL_FILE_CORE="OMNIbus-v8.1.0.5-Core.linux64.zip"
ARG INSTALL_FILE_FP="8.1.0-TIV-NCOMNIbus-Linux-FP0014.zip"
ARG INSTALL_TMP="/tmp/install"

ENV NCHOME="/opt/IBM/tivoli/netcool" OMNIHOME="/opt/IBM/tivoli/netcool/omnibus" OBJSRV="NCOMS" OBJSRV_PORT="4100"

# Add dependencies
RUN yum --setopt=tsflags=nodocs -y update && \
    yum --setopt=tsflags=nodocs -y install tar hostname unzip audit-libs fontconfig freetype compat-libstdc++-33.i686 glibc.i686 gtk2 libICE libSM libX11 libXau libXcursor libXext libXft libXmu libXp libXpm libXrender libXt libXtst libstdc++.i686 libgcc.i686 libjpeg-turbo libpng12 motif dejavu-fonts-common dejavu-sans-fonts expat glibc libgcc libidn libstdc++ libuuid libxcb nss-softokn-freebl pam zlib nss-softokn-freebl.i686 compat-libstdc++-33 && \
    rm -rf /var/cache/yum/* && yum clean all

# Add installation artifacts
COPY docker-entrypoint.sh "$INSTALL_TMP/scripts/"

# Add dedicated user
RUN mkdir -p $NCHOME "$INSTALL_TMP/core" "$INSTALL_TMP/fp" && \
    useradd -c "Netcool user" netcool && mkdir -p /db "$INSTALL_TMP" && chown -R netcool:netcool /db "$INSTALL_TMP" "$NCHOME" && \
    mv "$INSTALL_TMP/scripts/docker-entrypoint.sh" /

USER netcool

# Perform installation
RUN cd /tmp/install && \
    echo "Installing from $INSTALL_SOURCE/$INSTALL_FILE_CORE" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_CORE" &&  unzip -q -d "$INSTALL_TMP/core" "$INSTALL_FILE_CORE" && \
    echo "Installing from $INSTALL_SOURCE/$INSTALL_FILE_FP" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_FP" && unzip -q -d "$INSTALL_TMP/fp" "$INSTALL_FILE_FP" && \
    cd "$INSTALL_TMP/core" && ./install_silent.sh "$INSTALL_TMP/core/scripts/install_all.xml" -acceptLicense && \
    sed -i -e 's/update/install/' "$INSTALL_TMP/fp/scripts/update_omnibus.xml" && \
    cd "$INSTALL_TMP/fp" && ./update_silent.sh "$INSTALL_TMP/fp/scripts/update_omnibus.xml" acceptLicense && \
    chmod +x /docker-entrypoint.sh && \ 
# Optially remove Installation Manager stuff to lower image footprint
    rm -rf /home/netcool/var /home/netcool/IBM && \
    rm -rf /tmp/install

VOLUME /db

ENTRYPOINT /docker-entrypoint.sh
