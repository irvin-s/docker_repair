FROM fabric8/sti-java-centos7:1.0.0

MAINTAINER rhuss@redhat.com

EXPOSE 8080

ENV JETTY_VERSION 9.3.2.v20150730
ENV DEPLOY_DIR /maven

RUN curl http://download.eclipse.org/jetty/${JETTY_VERSION}/dist/jetty-distribution-${JETTY_VERSION}.tar.gz -o /tmp/jetty.tar.gz \
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
