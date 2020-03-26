FROM unocha/alpine-base-s6:latest

MAINTAINER Peter Lieverdink <ops+docker@humanitarianresponse.info>

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="filebeat" \
      org.label-schema.description="This service provides filebeat." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.4" \
      info.humanitarianresponse.filebeat=${VERSION}

ENV LANG=en_US.utf8 \
    FILEBEAT_VERSION=${VERSION} \
    FILEBEAT_SHA1=0f8e2f5f1145051435352b0e6a8b776040ea36e4 \
    FILEBEAT_CFG=/etc/filebeat/filebeat.yml

COPY run_filebeat filebeat* /

RUN apk add --update-cache curl && \
    curl https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -o /filebeat.tar.gz && \
    echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha1sum -c - && \
    tar xzvf filebeat.tar.gz && \
    cd filebeat-* && \
    cp filebeat /usr/bin && \
    mkdir -p /etc/filebeat && \
    mv /filebeat.yml /etc/filebeat/ && \
    mv /filebeat.template.json /etc/filebeat && \
    cd / && \
    rm -rf filebeat* && \
    mkdir -p /etc/services.d/filebeat && \
    mv /run_filebeat /etc/services.d/filebeat/run && \
    rm -rf /var/cache/apk/*

VOLUME ["/mnt"]
