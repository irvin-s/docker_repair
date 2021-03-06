FROM cmdlnprint-base

ARG FIREFOX_EXTENSIONS_DIR=/usr/lib/firefox-esr/browser/extensions/
ARG GIT_REPO=https://github.com/eclipxe13/cmdlnprint.git
ARG GIT_BRANCH=master

RUN set -e && \
    if [ -e /tmp/cmdlnprint ]; then rm -rf /tmp/cmdlnprint; fi && \
    mkdir -p /tmp/cmdlnprint && \
    git clone -b ${GIT_BRANCH} ${GIT_REPO} /tmp/cmdlnprint && \
    cd /tmp/cmdlnprint && \
    make build && \
    cd /tmp/cmdlnprint && \
    xpi_file=$(make info | awk '{print $4}') && \
    xpi_uuid=$(make info | awk '{print $3}') && \
    echo -e "\n\nInstalling ${xpi_file} -> ${FIREFOX_EXTENSIONS_DIR}/${xpi_uuid}.xpi" && \
    if [ ! -e ${FIREFOX_EXTENSIONS_DIR} ]; then mkdir -p ${FIREFOX_EXTENSIONS_DIR}; fi && \
    cp ${xpi_file} ${FIREFOX_EXTENSIONS_DIR}/${xpi_uuid}.xpi

EXPOSE 5900

ADD root /

ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint"]
