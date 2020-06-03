FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

ARG INSTALL_SOURCE="http://netcool.install:8000" 
ARG INSTALL_FILE_WAS="WAS_V8.5.5.9_FOR_JSM_FOR_LINUX_ML.zip"
ARG INSTALL_FILE_JAZZ="JAZZ_FOR_SM_1.1.3.0_FOR_LNX.zip"
ARG INSTALL_FILE_WEBGUI="OMNIbus-v8.1-WebGUI.linux64.zip"
ARG INSTALL_FILE_WEBGUI_FP="OMNIbus-v8.1.0-WebGUI-FP9-IM-Extensions-linux64-UpdatePack.zip"
ARG INSTALL_FILE_ITNM="ITNP_IP_LIN.zip"
ARG INSTALL_FILE_ITNM_FP="4.2.0-TIV-ITNMIP-Linux-FP0002.zip"
ARG INSTALL_TMP=/tmp/install
ARG INSTALL_OBJECTSERVER_PRIMARY_HOST="omnibus"
ARG INSTALL_OBJECTSERVER_PRIMARY_PORT=4100
ARG INSTALL_OBJECTSERVER_PRIMARY_NAME="NCOMS"
ARG INSTALL_OBJECTSERVER_USER="root"
ARG INSTALL_OBJECTSERVER_PASSWORD=""

ENV OBJECTSERVER_PRIMARY_HOST=omnibus OBJECTSERVER_PRIMARY_PORT=4100 OBJECTSERVER_PRIMARY_NAME=NCOMS OBJECTSERVER_USER=root OBJECTSERVER_PASSWORD="" SMADMIN_USERNAME="smadmin" SMADMIN_PASSWORD="smadmin"

# Add dependencies
RUN curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum --setopt=tsflags=nodocs -y localinstall epel-release-latest-7.noarch.rpm && \
    rm epel-release-latest-7.noarch.rpm && \
    yum --setopt=tsflags=nodocs -y update && \
    yum --setopt=tsflags=nodocs -y install \
    tar \
    hostname \
    unzip \
    audit-libs \
    fontconfig \
    freetype \
    compat-libstdc++-33.i686 \
    glibc.i686 \
    gtk2 \
    libICE \
    libSM \
    libX11 \
    libXau \
    libXcursor \
    libXext \
    libXft \
    libXmu \
    libXp \
    libXpm \
    libXrender \
    libXt \
    libXtst \
    libstdc++.i686 \
    libgcc.i686 \
    libjpeg-turbo \
    libpng12 \
    motif \
    dejavu-fonts-common \
    dejavu-sans-fonts \
    expat \
    glibc \
    libgcc \
    libidn \
    libstdc++ \
    libuuid \
    libxcb \
    nss-softokn-freebl \
    pam \
    zlib \
    nss-softokn-freebl.i686 \
    xmlstarlet \
    compat-libstdc++-33 && \
    rm -rf /var/cache/yum/* && \
    yum clean all

COPY response_was_jazz_webgui.xml response_itnm.xml docker-entrypoint-functions.sh docker-entrypoint.sh $INSTALL_TMP/

RUN mkdir -p /opt/IBM $INSTALL_TMP/{was,jazz,webgui,webgui-fp,itnm,itnm-fp} /docker-entrypoint.d /docker-init.d && \
    useradd -c "Netcool user" netcool && mkdir -p /db $INSTALL_TMP && \
    mv $INSTALL_TMP/docker-entrypoint* / && \
    chown -R netcool:netcool $INSTALL_TMP /opt/IBM /docker-entrypoint.d /docker-init.d /docker-entrypoint.sh /docker-entrypoint-functions.sh  && \
    chmod +x /docker-entrypoint.sh /docker-entrypoint-functions.sh

USER netcool

RUN cd /tmp/install && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_JAZZ"      && unzip -q -d "$INSTALL_TMP/jazz" "$INSTALL_FILE_JAZZ" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_WAS"       && unzip -q -d "$INSTALL_TMP/was" "$INSTALL_FILE_WAS" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_WEBGUI"    && unzip -q -d "$INSTALL_TMP/webgui" "$INSTALL_FILE_WEBGUI" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_WEBGUI_FP" && unzip -q -d "$INSTALL_TMP/webgui-fp" "$INSTALL_FILE_WEBGUI_FP" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_ITNM"      && unzip -q -d "$INSTALL_TMP/itnm" "$INSTALL_FILE_ITNM" && \
    curl -O "$INSTALL_SOURCE/$INSTALL_FILE_ITNM_FP"   && unzip -q -d "$INSTALL_TMP/itnm-fp" "$INSTALL_FILE_ITNM_FP" && \
    rm -rf "$INSTALL_FILE_WAS" "$INSTALL_FILE_JAZZ" "$INSTALL_FILE_WEBGUI" "$INSTALL_FILE_WEBGUI_FP" "$INSTALL_FILE_ITNM" "$INSTALL_FILE_ITNM_FP" 

RUN  . /docker-entrypoint-functions.sh && \
    { [ -n "$INSTALL_OBJECTSERVER_PRIMARY_HOST" ] && OBJECTSERVER_PRIMARY_HOST="$INSTALL_OBJECTSERVER_PRIMARY_HOST";}; \
    { [ -n "$INSTALL_OBJECTSERVER_PRIMARY_PORT" ] && export OBJECTSERVER_PRIMARY_PORT="$INSTALL_OBJECTSERVER_PRIMARY_PORT";}; \
    { [ -n "$INSTALL_OBJECTSERVER_PRIMARY_NAME" ] && export OBJECTSERVER_PRIMARY_NAME="$INSTALL_OBJECTSERVER_PRIMARY_NAME";};  \
    { [ -n "$INSTALL_OBJECTSERVER_USER" ] && export OBJECTSERVER_USER="$INSTALL_OBJECTSERVER_USER";}; \
    { [ -n "$INSTALL_OBJECTSERVER_PASSWORD" ] && export OBJECTSERVER_PASSWORD="$INSTALL_OBJECTSERVER_PASSWORD";}; \
    mv "$INSTALL_TMP/response_was_jazz_webgui.xml" "$INSTALL_TMP/jazz/im.linux.x86_64/install.xml" && \
    cd "$INSTALL_TMP/jazz/im.linux.x86_64" && ./userinstc --launcher.ini user-silent-install.ini  -acceptLicense && \
    backupNCWDataSources && stopJazzSM && configureNCWDataSources && startJazzSM && \
    mv "$INSTALL_TMP/response_itnm.xml" "$INSTALL_TMP/jazz/im.linux.x86_64/install.xml" && \
    cd "$INSTALL_TMP/jazz/im.linux.x86_64" && ./userinstc --launcher.ini user-silent-install.ini  -acceptLicense && \
    stopJazzSM && restoreNCWDataSources && \
    rm -rf /tmp/install

ENTRYPOINT /docker-entrypoint.sh
