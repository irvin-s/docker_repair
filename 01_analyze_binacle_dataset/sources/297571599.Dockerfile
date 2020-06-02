FROM alpine:3.6

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.basicfiltering="0.1.8" \
      version.alpine="3.6" \
      source.basicfiltering="https://github.com/mskcc/basicfiltering/releases/tag/0.1.8"

ENV BASICFILTERING_VERSION 0.1.8

RUN apk add --update \
      # for wget
            && apk add ca-certificates openssl wget \
      # for compilation
            && apk add build-base musl-dev python py-pip python-dev \
      # fix numpy compilation issue
            && ln -s /usr/include/locale.h /usr/include/xlocale.h \
      # download, unzip, install basic-filtering
            && cd /tmp && wget https://github.com/mskcc/basicfiltering/archive/${BASICFILTERING_VERSION}.zip \
            && unzip ${BASICFILTERING_VERSION}.zip \
            && cd /tmp/basicfiltering-${BASICFILTERING_VERSION} \
            && python setup.py install \
      # copy to /usr/bin
            && cp ./pindel/filter_pindel.py /usr/bin/ \
            && cp ./mutect/filter_mutect.py /usr/bin/ \
            && cp ./vardict/filter_vardict.py /usr/bin/ \
            && cp ./somaticindeldetector/filter_sid.py /usr/bin \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

# disable per-user site-packages before run
ENV PYTHONNOUSERSITE set

ENTRYPOINT ["/bin/sh"]
