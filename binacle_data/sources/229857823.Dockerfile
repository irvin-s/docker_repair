FROM centos:centos6
MAINTAINER Fabien MARTY <fabien.marty@gmail.com>

ENV DCO_CRONIE_START=1 \
    DCO_RSYSLOG_START=1 \
    DCO_RSYSLOG_REMOTE_HOST=null \
    DCO_RSYSLOG_REMOTE_PORT=514 \
    DCO_RSYSLOG_LOCAL_FILES=1

COPY root /

RUN /build/update.sh && \
    /build/add_epel.sh && \
    /build/add_runtime_dependencies.sh && \
    /build/add_common_buildtime_dependencies.sh && \
    /build/envtpl.sh && \
    /build/logger.sh && \
    /build/s6_overlay.sh && \
    /build/rsyslog.sh && \
    /build/cronie.sh && \
    /build/remove_buildtime_dependencies.sh

ENTRYPOINT ["/init"]
