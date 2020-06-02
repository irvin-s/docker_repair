FROM fabric8/java-centos-openjdk7-jdk:1.0.0

MAINTAINER rhuss@redhat.com

EXPOSE 8080 8778

ENV JETTY_VERSION 5.1.12
ENV DEPLOY_DIR /maven

RUN curl http://mirrors.ibiblio.org/maven/jetty/jetty-5.1.x/jetty-${JETTY_VERSION}.zip -o /tmp/jetty.zip \
 && cd /opt && jar xvf /tmp/jetty.zip \
 && ln -s /opt/jetty-${JETTY_VERSION} /opt/jetty \
 && rm /tmp/jetty.zip

# Startup script
ADD deploy-and-run.sh /opt/jetty/bin/
RUN chmod a+x /opt/jetty/bin/deploy-and-run.sh

ENV JETTY_HOME /opt/jetty
ENV PATH $PATH:$JETTY_HOME/bin

CMD /opt/jetty/bin/deploy-and-run.sh
