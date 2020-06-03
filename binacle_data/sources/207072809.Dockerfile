FROM unocha/alpine-base-s6:%%UPSTREAM%%

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV LDAPS=no \
    EXTRA_OPTIONS="-d 0" \
    SUFFIX=org \
    DOMAIN=example \
    MNGRPASS=changeit \
    REPLICATE=yes \
    REMOTE=ldap2 \
    REPLPASS=changeit \
    SID=1 \
    JOHNPASS=changeit \
    BCRYPT=no

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="openldap" \
      org.label-schema.description="This service provides a base openldap platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="%%UPSTREAM%%" \
      info.humanitarianresponse.openldap="2.4.46-r0"

COPY base.ldif.tpl bcrypt.tpl fix_ldap_dirs john.ldif.tpl pw-bcrypt.so run_slapd slapd-init.conf slapd.tpl ssl.tpl syncrepl.tpl /tmp/

# Install openldap.
RUN apk update && \
    apk upgrade && \
    apk add \
      gettext \
      openldap-back-mdb \
      openldap-clients \
      openldap \
      openldap-overlay-memberof \
      openldap-overlay-ppolicy \
      openldap-overlay-syncprov && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /run/openldap /etc/fix-attrs.d /etc/services.d/slapd /etc/openldap/conf.d && \
    mv /tmp/base.ldif.tpl /etc/openldap/ && \
    mv /tmp/john.ldif.tpl /etc/openldap/ && \
    mv /tmp/slapd-init.conf /etc/openldap/ && \
    chown root:ldap /etc/openldap/slapd-init.conf && \
    chmod 640 /etc/openldap/slapd-init.conf && \
    mv /tmp/bcrypt.tpl /etc/openldap/ && \
    mv /tmp/slapd.tpl /etc/openldap/ && \
    mv /tmp/ssl.tpl /etc/openldap/ && \
    mv /tmp/syncrepl.tpl /etc/openldap/ && \
    mv /tmp/run_slapd /etc/services.d/slapd/run && \
    mv /tmp/fix_ldap_dirs /etc/fix-attrs.d/ && \
    mv /tmp/pw-bcrypt.so /usr/lib/openldap/

    #mv /var/lib/openldap/openldap-data/DB_CONFIG.example /var/lib/openldap/openldap-data/DB_CONFIG
    #mv /etc/openldap/slapd.conf /etc/openldap/slapd.conf.orig && \

EXPOSE 389 636

# Volumes
# - Conf: /etc/openldap
# - Logs: /var/log/openldap
# - Data: /var/lib/opeldap
