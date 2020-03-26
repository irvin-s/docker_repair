ARG ARCH=frommakefile
ARG DOCKERSRC=frommakefile
ARG USERNAME=frommakefile
#
FROM ${USERNAME}/${DOCKERSRC}:${ARCH}
#
ARG PUID=991
ARG PGID=991
#
ENV BASE_URL=False IMAGE_PROXY=False
RUN set -xe \
    && apk add -Uu --no-cache --purge \
	    libxml2 \
	    libxslt \
	    openssl \
    && apk add --no-cache -t build-dependencies \
        curl \
	    build-base \
	    python3-dev \
	    libffi-dev \
	    libxslt-dev \
	    libxml2-dev \
	    openssl-dev \
	    tar \
	    ca-certificates \
    && pip install -v --no-cache -r https://raw.githubusercontent.com/asciimoo/searx/master/requirements.txt \
    && mkdir /usr/local/searx \
    && cd /usr/local/searx \
    && curl -SL https://github.com/asciimoo/searx/archive/master.tar.gz | tar xz --strip 1 \
    && sed -i "s/127.0.0.1/0.0.0.0/g" searx/settings.yml \
    && apk del --purge build-dependencies \
    && rm -f /var/cache/apk/* /tmp/*
#
COPY root/ /
#
VOLUME /data
#
EXPOSE 8888
#
ENTRYPOINT ["/init"]
