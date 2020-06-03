FROM node:10-alpine as glibcbuild


ENV LANG=C.UTF-8

# Here we install GNU libc (aka glibc) and set C.UTF-8 locale as default.

RUN ALPINE_GLIBC_BASE_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download" && \
    ALPINE_GLIBC_PACKAGE_VERSION="2.29-r0" && \
    ALPINE_GLIBC_BASE_PACKAGE_FILENAME="glibc-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_BIN_PACKAGE_FILENAME="glibc-bin-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    ALPINE_GLIBC_I18N_PACKAGE_FILENAME="glibc-i18n-$ALPINE_GLIBC_PACKAGE_VERSION.apk" && \
    apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    echo \
        "-----BEGIN PUBLIC KEY-----\
        MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApZ2u1KJKUu/fW4A25y9m\
        y70AGEa/J3Wi5ibNVGNn1gT1r0VfgeWd0pUybS4UmcHdiNzxJPgoWQhV2SSW1JYu\
        tOqKZF5QSN6X937PTUpNBjUvLtTQ1ve1fp39uf/lEXPpFpOPL88LKnDBgbh7wkCp\
        m2KzLVGChf83MS0ShL6G9EQIAUxLm99VpgRjwqTQ/KfzGtpke1wqws4au0Ab4qPY\
        KXvMLSPLUp7cfulWvhmZSegr5AdhNw5KNizPqCJT8ZrGvgHypXyiFvvAH5YRtSsc\
        Zvo9GI2e2MaZyo9/lvb+LbLEJZKEQckqRj4P26gmASrZEPStwc+yqy1ShHLA0j6m\
        1QIDAQAB\
        -----END PUBLIC KEY-----" | sed 's/   */\n/g' > "/etc/apk/keys/sgerrand.rsa.pub" && \
    wget \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BASE_URL/$ALPINE_GLIBC_PACKAGE_VERSION/$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    apk add --no-cache \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME" && \
    \
    rm "/etc/apk/keys/sgerrand.rsa.pub" && \
    /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 "$LANG" || true && \
    echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
    \
    apk del glibc-i18n && \
    \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        "$ALPINE_GLIBC_BASE_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_BIN_PACKAGE_FILENAME" \
        "$ALPINE_GLIBC_I18N_PACKAGE_FILENAME"



FROM glibcbuild

ARG GITHUB_TOKEN
ARG PY_REQUIREMENTS
ENV TINI_VERSION v0.16.1
LABEL band.images.theia.version="0.2.0"

ENV RST_UID=472 \ 
    RST_GID=472 \
    WORKSPACE_PATH=/home/theia/project \
    BUILD_PATH=/home/theia/.build \
    THEIA=/home/theia/.build/theia \
    LANG=C.UTF-8

RUN apk add --no-cache \
    ca-certificates \
    make gcc g++ \
    util-linux pciutils usbutils coreutils binutils findutils grep \
    libffi-dev \
    gzip bzip2 curl nano jq \
    git openssh-client \
    su-exec sudo zsh \
    python

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/zsh ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh \
    && /opt/conda/bin/conda clean -tipsy \
    && chmod 0755 /opt/conda/etc/profile.d/conda.sh

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

WORKDIR /home/theia

RUN echo "theia ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default \
    && chmod 0440 /etc/sudoers.d/default \
    && addgroup -g ${RST_GID} theia \
    && adduser -u ${RST_UID} -G theia -s /bin/sh -D theia \
    && chmod g+rw /home/theia \
    && mkdir -p ${HOME}/.build ${HOME}/project  \
    && chown -R theia:theia /opt/conda

USER theia

ENV PORT_THEIA=${PORT_THEIA:-8000} \
    PORT=${PORT_DEV:-8080} \
    SHELL=/bin/zsh \
    USE_LOCAL_GIT=true \
    VIRTUAL_ENV_DISABLE_PROMPT=yes \
    JSON_LOGS=0

# ##### ZSH

COPY --chown=theia:theia prezto.tgz init_zprezto ${BUILD_PATH}/
RUN cd ${BUILD_PATH} && \
    tar -zxf prezto.tgz && \
    mv prezto $HOME/.zprezto && \
    ./init_zprezto 


# ##### Node.js part

COPY --chown=theia:theia package/package.json ./.build

RUN cd ${BUILD_PATH} && yarn --cache-folder ./ycache && rm -rf ./ycache
RUN cd ${BUILD_PATH} && yarn theia build

ENV NODE_ENV=production

# ##### Python part

RUN /opt/conda/bin/conda upgrade -y pip && \
    /opt/conda/bin/conda config --add channels conda-forge && \
    /opt/conda/bin/conda clean --all

ENV PATH /opt/conda/bin:$PATH
COPY --chown=theia:theia requirements.txt .editorconfig ${BUILD_PATH}/

RUN pip install -U git+https://github.com/rockstat/band@master#egg=band \
    && pip install -U -r ${BUILD_PATH}/requirements.txt

COPY --chown=theia:theia init_app ./.build/
COPY --chown=theia:theia .theia/settings.json .theia/tasks.json .theia/tasks.json-tmpl ./.build/.theia/

EXPOSE 8080 8000

# ENTRYPOINT [ "/usr/bin/tini", "--" ]

CMD ${BUILD_PATH}/init_app
