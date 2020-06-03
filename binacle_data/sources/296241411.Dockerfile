FROM bailaohe/parade

RUN pip --no-cache-dir install --upgrade pip
RUN apk add --no-cache libstdc++

RUN apk add --no-cache --virtual .build-deps  \
        python3-dev \
        bzip2-dev \
        libffi-dev \
        coreutils \
        dpkg-dev dpkg \
        expat-dev \
        gcc \
        g++ \
        gdbm-dev \
        libc-dev \
        libffi-dev \
        linux-headers \
        make \
        ncurses-dev \
        openssl \
        libressl-dev \
        pax-utils \
        readline-dev \
        sqlite-dev \
        tcl-dev \
        tk \
        tk-dev \
        xz-dev \
        zlib-dev \
        libxml2-dev \
        libxslt-dev \
    && pip --no-cache-dir install flask-ldap3-login \
    && pip --no-cache-dir install python-consul \
    && pip --no-cache-dir install jira \
    && apk del .build-deps

ENV PARADE_WORKSPACE="/workspace"
ENV PARADE_PROFILE="default"

VOLUME /cache-directory

WORKDIR /

EXPOSE 8888

CMD ["parade", "server", "--enable-dash", "-p", "8888"]