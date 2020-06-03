FROM {{= fp.config.version.from.jre8 }}:{{= fp.config.version.from.version }}

MAINTAINER {{= fp.maintainer }}

EXPOSE 8080

ENV JETTY_VERSION {{= fp.config.version.version }}
ENV DEPLOY_DIR /maven

RUN curl {{= fp.config.version.downloadUrl }} -o /tmp/jetty.tar.gz \
 && cd /opt && tar zxvf /tmp/jetty.tar.gz \
 && ln -s /opt/jetty-distribution-${JETTY_VERSION} /opt/jetty \
 && rm /tmp/jetty.tar.gz

# Startup script
ADD deploy-and-run.sh /opt/jetty/bin/
ADD jetty-logging.xml /opt/jetty/etc/
RUN chmod a+x /opt/jetty/bin/deploy-and-run.sh

ENV JETTY_HOME /opt/jetty
ENV PATH $PATH:$JETTY_HOME/bin

CMD /opt/jetty/bin/deploy-and-run.sh
