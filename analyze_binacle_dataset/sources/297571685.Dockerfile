FROM java:7-alpine

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.picard="1.96" \
      version.r="3.3.2-r0" \
      version.alpine="3.4.6" \
      source.picard="https://github.com/broadinstitute/picard/releases/tag/1.96" \
      source.r="https://pkgs.alpinelinux.org/package/v3.5/community/x86_64/R"

ENV PICARD_VERSION 1.96
ENV R_VERSION 3.3.2-r0

COPY picard-${PICARD_VERSION}.tgz /tmp/

RUN apk add --update \
      # for wget
            && apk add ca-certificates openssl \
      # install R (only avail in Alpine 3.5 Community)
            && apk add R=${R_VERSION} --update-cache --repository http://dl-5.alpinelinux.org/alpine/v3.5/community --allow-untrusted \
      # uncompress and copy jar to /usr/bin
            && mkdir -p /usr/bin/picard-tools \
            && tar xvzf /tmp/picard-${PICARD_VERSION}.tgz -C /usr/bin/picard-tools \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

CMD ["java", "-jar", "/usr/bin/picard-tools/AddOrReplaceReadGroups.jar", "--version"]
