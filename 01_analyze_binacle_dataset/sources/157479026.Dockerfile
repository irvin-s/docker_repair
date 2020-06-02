FROM noi/db2
MAINTAINER Julius Loman <lomo@kyberia.net>

ARG INSTALL_SOURCE="http://netcool.install:8000" 
ARG INSTALL_FILE_TCR="ITCR_3.1.3.0_FOR_LINUX.tar.gz"
ARG INSTALL_TMP=/tmp/install

RUN mkdir "$INSTALL_TMP" && \
    curl "$INSTALL_SOURCE/$INSTALL_FILE_TCR" && tar xzv -C "$INSTALL_TMP" "TCRCognos/ContentStoreDatabase/TCR_generate_content_store_db2_definition.sh" && \
    cd /docker-init-postinstance.d" && sh "$INSTALL_TMP/TCRCognos/ContentStoreDatabase/TCR_generate_content_store_db2_definition.sh" TCR3 db2inst1 && \
    rm -rf "$INSTALL_TMP"

COPY tcr_000_preparedb.sh /docker-init-postinstance.d
