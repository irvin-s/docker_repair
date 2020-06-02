FROM rsoares/java-base

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael T. C. Soares <rafaelcba@gmail.com>

ENV RHQ_AGENT_HOME=/opt/redhat/rhq-agent 
ENV RHQ_JAVA_HOME=$JAVA_HOME 
ENV RHQ_AGENT_DEBUG=true

# set the agent properties in a way it don't need a static agent-configuration.xml
ENV RHQ_AGENT_ADDITIONAL_JAVA_OPTS="-Drhq.agent.configuration-setup-flag=true -Drhq.agent.server.bind-address=jon-server -Drhq.agent.wait-for-server-at-startup-msecs=600000"

COPY software/rhq-enterprise-agent-*.jar /tmp/

RUN java -jar /tmp/rhq-enterprise-agent-*.jar --install=$SOFTWARE_INSTALL_DIR
RUN rm /tmp/rhq-enterprise-agent-*.jar

ENTRYPOINT ["/opt/redhat/rhq-agent/bin/rhq-agent.sh"]

CMD ["--help"]
