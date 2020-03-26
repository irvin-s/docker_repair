FROM unocha/alpine-base-s6:%%UPSTREAM%%

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
      org.label-schema.name="base-s6" \
      org.label-schema.description="This service provides a base SFTPd Alpine Linux container." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version=$VERSION

ENV SFTP_USER=user \
    SFTP_PASS=pass \
    SFTP_PUBKEY=garblegarblegarble \
    SFTP_PASS_AUTH=no \
    SFTP_HOME=/srv/user

COPY run_sftp /tmp/

RUN apk add --update-cache \
        openssh-sftp-server \
        dropbear && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/dropbear /etc/services.d/sftp && \
    mv /tmp/run_sftp /etc/services.d/sftp/run

EXPOSE 22
