FROM centos:centos7

MAINTAINER Richard Louapre <richard.louapre@marklogic.com>

ENV ML_RPM_FILE MarkLogic.rpm

# RUN yum -y update && yum clean all

# Download ML rpm
ADD ${ML_RPM_FILE} /tmp/${ML_RPM_FILE}

# Install MarkLogic, Python
# RUN yum -y update && yum -y install \
RUN yum -y install \
  initscripts \
  /tmp/${ML_RPM_FILE} \
  python-setuptools 

# Install, Supervisor
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

# Clean up
RUN yum clean all && rm -rf /tmp/*

WORKDIR /
# Expose MarkLogic admin
EXPOSE 7997 7998 7999 8000 8001 8002
# Run Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"] 
