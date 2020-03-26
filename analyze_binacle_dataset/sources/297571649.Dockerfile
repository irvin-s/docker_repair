FROM alpine:3.4

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.getBaseCountsMultiSample="1.2.1" \
      version.alpine="3.4.x" \
      source.getBaseCountsMultiSample="https://github.com/zengzheng123/GetBaseCountsMultiSample/releases/tag/v1.2.1"

ENV GET_BASE_COUNTS_MULTI_SAMPLE_VERSION 1.2.1

RUN apk add --update \
      # for wget
            && apk add ca-certificates openssl \
      # for source compilation
            && apk add gcc g++ make cmake musl-dev zlib-dev \
      # download and unzip gbcms
            && cd /tmp && wget https://github.com/zengzheng123/GetBaseCountsMultiSample/archive/v${GET_BASE_COUNTS_MULTI_SAMPLE_VERSION}.zip \
            && unzip v${GET_BASE_COUNTS_MULTI_SAMPLE_VERSION}.zip \
      # replace hardcoded path, use make instead of gmake
            && cd /tmp/GetBaseCountsMultiSample-${GET_BASE_COUNTS_MULTI_SAMPLE_VERSION}/bamtools-master/build \
            && sed -i "s|/ifs/data/zeng/count_error/CountErrors/|/tmp/GetBaseCountsMultiSample-${GET_BASE_COUNTS_MULTI_SAMPLE_VERSION}/|g" CMakeCache.txt \
            && sed -i "s|/usr/bin/gmake|/usr/bin/make|g" CMakeCache.txt \
      # build bamtools
            && cmake . && make \
      # copy libbamtools to /usr/lib/
            && cp ../lib/libbamtools.so.2.3.0 /usr/lib/ \
      # build gbcms
            && cd /tmp/GetBaseCountsMultiSample-${GET_BASE_COUNTS_MULTI_SAMPLE_VERSION} \
            && make \
      # copy bins to /usr/lib/
            && cp GetBaseCountsMultiSample /usr/bin/ \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["/usr/bin/GetBaseCountsMultiSample"]
CMD ["--help"]
