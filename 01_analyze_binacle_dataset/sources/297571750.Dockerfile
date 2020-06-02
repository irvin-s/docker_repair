FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.trimgalore="0.4.3" \
      version.cutadapt="1.12" \
      version.alpine="3.8" \
      source.trimgalore="https://github.com/FelixKrueger/TrimGalore/releases/tag/0.4.3" \
      source.cutadapt="https://github.com/marcelm/cutadapt/releases/tag/v1.12"

ENV TRIM_GALORE_VERSION 0.4.3
ENV CUTADAPT_VERSION 1.12

# gcc python-dev musl-dev required by cutadapt
RUN apk add --update python py-pip perl gcc python-dev musl-dev \
      && cd /tmp && wget http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/trim_galore_v${TRIM_GALORE_VERSION}.zip \
      && unzip trim_galore_v${TRIM_GALORE_VERSION} \
      && rm -rf /tmp/trim_galore_v${TRIM_GALORE_VERSION}.zip \
      && mv /tmp/trim_galore /usr/bin/ \
      && pip install --upgrade cutadapt==${CUTADAPT_VERSION} \
      && rm -rf /var/cache/apk/*
      
ENTRYPOINT ["/usr/bin/trim_galore"]
CMD ["--help"]
