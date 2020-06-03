FROM python:2-alpine3.6 as builder

COPY qemu-*-static /usr/bin/

FROM builder

ARG VERSION=0.4.4
LABEL maintainer="Jay MOULIN <jaymoulin@gmail.com> <https://twitter.com/MoulinJay>"
LABEL version="${VERSION}"
EXPOSE 631
RUN apk add --update --no-cache --virtual .build-deps g++ && \
    apk add --update --no-cache cups cups-dev cups-filters && \
    python -m ensurepip --default-pip && \
    pip install --upgrade pip &&\
    pip install cloudprint[daemon] && \
    apk del g++ --purge .build-deps && \
    sed -r -i 's/(Order allow\,deny)/\1\n  Allow all/' /etc/cups/cupsd.conf && \
    echo "DefaultEncryption Never" >> /etc/cups/cupsd.conf && \
    rm /usr/bin/qemu-*-static
COPY configure.sh /usr/bin/configure
COPY daemon.sh /usr/bin/daemon
VOLUME ["/root"]
CMD ["daemon"]
