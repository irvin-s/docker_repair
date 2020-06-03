FROM alpine:3.8

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      version.image="1.0.0" \
      version.basicfiltering="0.2.0" \
      version.alpine="3.8" \
      source.basicfiltering="https://github.com/mskcc/basicfiltering/releases/tag/0.2.0"

ENV BASICFILTERING_VERSION 0.2.0

RUN apk add --update \
      # for wget
            && apk add ca-certificates openssl \
      # for compilation
            && apk add build-base musl-dev python py-pip python-dev \
      # download, unzip, install basic-filtering
            && cd /tmp && wget https://github.com/mskcc/basicfiltering/archive/${BASICFILTERING_VERSION}.zip \
            && unzip ${BASICFILTERING_VERSION}.zip \
            && cd /tmp/basicfiltering-${BASICFILTERING_VERSION} \
            && python setup.py install \
      # copy to /usr/bin
            && cp filter_pindel.py /usr/bin/ \
            && cp filter_mutect.py /usr/bin/ \
            && cp filter_vardict.py /usr/bin/ \
            && cp filter_sid.py /usr/bin \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

# disable per-user site-packages before run
ENV PYTHONNOUSERSITE set

ENTRYPOINT ["/bin/sh"]
