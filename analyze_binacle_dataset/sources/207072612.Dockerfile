FROM unocha/alpine-base-mysql:%%UPSTREAM%%

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

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
      org.label-schema.name="alpine-varnish" \
      org.label-schema.description="This service provides a mysql service using MariaDB" \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.mysql=$VERSION

ENV LANG=en_US.utf8 \
    MYSQL_DIR=/var/lib/mysql \
    MYSQL_ROOT_PASS=rootpass \
    MYSQL_DB=test_db \
    MYSQL_USER=test_user \
    MYSQL_PASS=test_pass

COPY run_mysql fix_* /

RUN mkdir -p /etc/services.d/mysql && \
    mv /run_mysql /etc/services.d/mysql/run && \
    mkdir -p /etc/fix-attrs.d && \
    cp /fix_data_dir /etc/fix-attrs.d/01-fix-data-dir && \
    cp /fix_logs_dir /etc/fix-attrs.d/02-fix-logs-dir && \
    cp /fix_tmp_dir  /etc/fix-attrs.d/03-fix-tmp-dir

EXPOSE 3306

VOLUME /var/lib/mysql /var/log/mysql /var/tmp/mysql
