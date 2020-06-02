FROM rsoares/java-base

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV JON_VERSION=3.3.0.GA

 # Create the wildfly user and group
RUN groupadd -f -r jboss -g 433 && \
    useradd -u 431 -r -g jboss -d /opt/redhat \
    -c "JBoss EAP admin user" jboss

COPY software/*.zip       /tmp/
COPY software/patch/* /tmp/patch/

COPY support/applyPatch.sh  /
COPY support/install_rhq.sh /
RUN /install_rhq.sh

COPY support/run.sh /

RUN chown -Rf jboss.jboss $SOFTWARE_INSTALL_DIR/

EXPOSE 7080

ENTRYPOINT ["/run.sh"]
