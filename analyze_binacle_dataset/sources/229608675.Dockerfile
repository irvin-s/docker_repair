### Use the official base image from Red Hat Container Catalog (https://access.redhat.com/containers/)
FROM registry.access.redhat.com/rhscl/httpd-24-rhel7

### File Author / Maintainer
LABEL maintainer="sebastian.faulhaber@redhat.com"

### Customize Apache HTTPD according to your needs
COPY config/httpd.conf /etc/httpd/conf/httpd.conf
