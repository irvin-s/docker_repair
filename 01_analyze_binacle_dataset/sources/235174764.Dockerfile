FROM tomcat:8.5

WORKDIR /usr/local
RUN mkdir -p /usr/local/pinpoint-agent && rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/examples
ADD pinpoint-agent-1.6.0.tar.gz /usr/local/pinpoint-agent
ADD configure-agent.sh /usr/local/bin/

ADD pinpoint.config /usr/local/pinpoint-agent/pinpoint.config
RUN chmod a+x /usr/local/bin/configure-agent.sh

ENTRYPOINT ["/usr/local/bin/configure-agent.sh"]

