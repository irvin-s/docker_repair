FROM centos:7
MAINTAINER Julius Loman <lomo@kyberia.net>

ARG INSTALL_SOURCE="http://netcool.install:8000" 
ARG INSTALL_FILE_DB2="DB2_Svr_10.5.0.3_Linux_x86-64.tar.gz"
ARG INSTALL_FILE_DB2_FP="v10.5fp8_linuxx64_universal_fixpack.tar.gz"
ARG INSTALL_FILE_DB2_LIC="DB2_ESE_Restricted_QS_Act_10.5.0.1.zip"
ARG INSTALL_TMP=/tmp/install

ENV DB2INSTANCE=db2inst1 DB2INSTANCE_PASSWORD=db2inst1 DB2INSTANCE_FENCEDUSER=db2fenc1 DB2INSTANCE_FENCEDUSER_PASSWORD="db2fenc1" DB2INSTANCE_PORT=50000 DB2INSTANCE_OPTS="" DB2INSTANCE_DATABASE=""

# Add dependencies
RUN curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum --setopt=tsflags=nodocs -y localinstall epel-release-latest-7.noarch.rpm && \
    rm epel-release-latest-7.noarch.rpm && \
    yum --setopt=tsflags=nodocs -y update && \
    yum --setopt=tsflags=nodocs -y install \
    tar \
    hostname \
    unzip \
    compat-libstdc++-33 \
    libaio \
    pam \
    pam.i686 \
    file \
    zlib && \  
    rm -rf /var/cache/yum/* && \
    yum clean all

COPY db2resp $INSTALL_TMP/

RUN mkdir -p /opt/ibm $INSTALL_TMP/{db2,db2-fp,lic} /docker-entrypoint.d /docker-init-preinstance.d /docker-init-postinstance.d && \
    cd $INSTALL_TMP && \
    curl "$INSTALL_SOURCE/$INSTALL_FILE_DB2" | tar -xz -C "$INSTALL_TMP/db2" && \
    ( [ -n "$INSTALL_FILE_DB2_FP" ] && curl "$INSTALL_SOURCE/$INSTALL_FILE_DB2_FP"  | tar -xz -C "$INSTALL_TMP/db2-fp" ) && \
    ( [ -n "$INSTALL_FILE_DB2_LIC" ] && curl -O "$INSTALL_SOURCE/$INSTALL_FILE_DB2_LIC" && unzip "$INSTALL_FILE_DB2_LIC" -d "$INSTALL_TMP/lic" ) && \
    cd "$INSTALL_TMP/db2/server" && ./db2setup -r $INSTALL_TMP/db2resp && \
    ( [ -n "$INSTALL_FILE_DB2_FP" ] && cd $INSTALL_TMP/db2-fp/* && ./installFixPack -b /opt/ibm/db2 ) && \
    ( [ -e "$INSTALL_TMP/lic/ese_o/db2/license/db2ese_o.lic" ] && /opt/ibm/db2/adm/db2licm -a "$INSTALL_TMP/lic/ese_o/db2/license/db2ese_o.lic" ) && \
    rm -rf "$INSTALL_TMP"

COPY docker-entrypoint.sh /

ENTRYPOINT /docker-entrypoint.sh
