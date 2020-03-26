FROM jboss/wildfly:10.0.0.Final
USER root

# Install packages necessary to install cct
RUN yum -y install python python-setuptools git && yum clean all

# Install cct
RUN git clone https://github.com/containers-tools/cct \
     && cd cct \
     && easy_install . \
     && cd .. \
     && rm -rf cct

USER jboss
# register cct in the image
ENTRYPOINT ["/usr/bin/cct", "-vc"]

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
