FROM centos/postgresql-94-centos7

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV TERM xterm
ENV SOFTWARE_INSTALL_DIR /opt/redhat
ENV JAVA_HOME /usr/lib/jvm/jre

USER root

# install the JRE to run RHQ Agent
RUN yum install -y java-1.7.0-openjdk; yum clean all

RUN mkdir $SOFTWARE_INSTALL_DIR; chown postgres.postgres $SOFTWARE_INSTALL_DIR

VOLUME /dnsmasq.hosts

USER postgres

# install the RHQ/JON Agent to monitor the Postgres instance inside the container
COPY software/rhq-enterprise-agent-*.jar $SOFTWARE_INSTALL_DIR/
WORKDIR $SOFTWARE_INSTALL_DIR
RUN java -jar $SOFTWARE_INSTALL_DIR/rhq-enterprise-agent-*.jar --install=$SOFTWARE_INSTALL_DIR
RUN rm $SOFTWARE_INSTALL_DIR/rhq-enterprise-agent-*.jar

# Apply some tuning to the original PG installation (from base image)
#COPY support/pg_tuning.conf /tmp/
#RUN cat /tmp/pg_tuning.conf >> /var/lib/pgsql/data/postgresql.conf

COPY support/*.sh /usr/bin/

# RHQ Agent TCP port
EXPOSE 16163

ENTRYPOINT ["/usr/bin/run.sh"]
