FROM java:7-alpine

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.picard="1.129" \
      version.alpine="3.4.6" \
      source.picard="https://github.com/broadinstitute/picard/releases/tag/1.129"

ENV TOOL_VERSION 1.129
ENV R_VERSION 3.3.2-r0

RUN apk add --update \
      && apk add ca-certificates openssl \
      && apk add R=${R_VERSION} --update-cache --repository http://dl-5.alpinelinux.org/alpine/v3.5/community --allow-untrusted \
      && cd /tmp && wget https://github.com/broadinstitute/picard/releases/download/${TOOL_VERSION}/picard-tools-${TOOL_VERSION}.zip \
      && unzip picard-tools-${TOOL_VERSION}.zip \
      && mv /tmp/picard-tools-${TOOL_VERSION} /usr/bin/picard-tools \
      && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["java", "-jar", "/usr/bin/picard-tools/picard.jar"]
