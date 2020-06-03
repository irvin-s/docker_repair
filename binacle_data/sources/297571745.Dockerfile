FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.trimgalore="0.2.5.mod" \
      version.cutadapt="1.1" \
      version.alpine="3.8" \
      source.trimgalore="http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/" \
      source.cutadapt="https://github.com/marcelm/cutadapt/releases/tag/v1.1"

ENV TRIM_GALORE_VERSION 0.2.5.mod
ENV CUTADAPT_VERSION 1.1

# MUST set permissions to 755 in the source data!!!!
# https://github.com/docker/docker/issues/1295
COPY trim_galore.pl /usr/bin/trim_galore

# gcc python-dev musl-dev required by cutadapt
RUN apk add --update python py-pip perl gcc python-dev musl-dev \
      && chmod +x /usr/bin/trim_galore \
      && pip install --upgrade cutadapt==${CUTADAPT_VERSION} \
      && rm -rf /var/cache/apk/*

# using trim_galore_v0.2.5.mod.tgz -------------------------------------------------------

# COPY trim_galore_v${TRIM_GALORE_VERSION}.tgz /tmp/trim_galore_v${TRIM_GALORE_VERSION}/

# # gcc python-dev musl-dev required by cutadapt
# RUN apk add --update python py-pip perl gcc python-dev musl-dev \
#       && cd /tmp/trim_galore_v${TRIM_GALORE_VERSION} \
#       && tar xvzf trim_galore_v${TRIM_GALORE_VERSION}.tgz \
#       && mv /tmp/trim_galore_v${TRIM_GALORE_VERSION}/trim_galore /usr/bin/ \
#       && rm -rf /tmp/trim_galore_v${TRIM_GALORE_VERSION} \
#       && cd / \
#       && pip install --upgrade cutadapt==${CUTADAPT_VERSION} \
#       && rm -rf /var/cache/apk/*

#-----------------------------------------------------------------------------------------

      
ENTRYPOINT ["/usr/bin/trim_galore"]
CMD ["--help"]
