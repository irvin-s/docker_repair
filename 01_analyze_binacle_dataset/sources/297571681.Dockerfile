FROM java:8-alpine

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.picard="1.96" \
      version.alpine="3.4.6" \
      source.picard="https://github.com/broadinstitute/picard/releases/tag/1.96"

ENV TOOL_VERSION 1.96

COPY picard-${TOOL_VERSION}.tgz /tmp/

RUN mkdir -p /usr/bin/picard-tools \
      && tar xvzf /tmp/picard-${TOOL_VERSION}.tgz -C /usr/bin/picard-tools \
      && rm -rf /var/cache/apk/* /tmp/*

CMD ["java", "-jar", "/usr/bin/picard-tools/AddOrReplaceReadGroups.jar", "--version"]
