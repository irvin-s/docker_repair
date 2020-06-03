FROM centos:centos6
MAINTAINER Fabien MARTY <fabien.marty@gmail.com>

ENV DCO_CRONIE_START=1 \
    DCO_RSYSLOG_START=1 \
    DCO_RSYSLOG_REMOTE_HOST=null \
    DCO_RSYSLOG_REMOTE_PORT=514 \
    DCO_RSYSLOG_LOCAL_FILES=1

# Update the image
RUN yum update -y

# Add EPEL repo (enabled=0 by default, you have to add --enablerepo=epel to use it)
ADD root/build/add_epel.sh /build/add_epel.sh
RUN /build/add_epel.sh

# Add runtime dependencies
ADD root/build/add_runtime_dependencies.sh /build/add_runtime_dependencies.sh
RUN /build/add_runtime_dependencies.sh

# Add build dependencies
ADD root/build/add_common_buildtime_dependencies.sh /build/add_common_buildtime_dependencies.sh
RUN /build/add_common_buildtime_dependencies.sh

# Add envtpl (https://github.com/andreasjansson/envtpl)
ADD root/build/envtpl.sh /build/envtpl.sh
RUN /build/envtpl.sh

# Build logger
ADD root/build/logger.sh /build/logger.sh
RUN /build/logger.sh

# Add "S6 overlay" (https://github.com/just-containers/s6-overlay)
ADD root/build/s6_overlay.sh /build/s6_overlay.sh
RUN /build/s6_overlay.sh

# Build and install rsyslog
ADD root/build/rsyslog.sh /build/rsyslog.sh
RUN /build/rsyslog.sh

# Build and install cronie
ADD root/build/cronie.sh /build/cronie.sh
RUN /build/cronie.sh

# Remove build dependencies
ADD root/build/remove_buildtime_dependencies.sh /build/remove_buildtime_dependencies.sh
RUN /build/remove_buildtime_dependencies.sh

# Add custom (other) files
COPY root /

ENTRYPOINT ["/init"]
