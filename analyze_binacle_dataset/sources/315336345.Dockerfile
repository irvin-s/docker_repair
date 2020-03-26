FROM openjdk:8u151-jdk-alpine3.7

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image with Apache Tomcat set up to be proxied by Apache mod proxy, to support shiny demo" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/shiny-tomcat8-proxied"

RUN apk add --update bash curl unzip zip tar

RUN sed -i -r -e 's/securerandom.source.+/securerandom.source=file:\/dev\/urandom/' /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/java.security

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN cd /tmp && \
  curl -SsO https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.50/bin/apache-tomcat-8.0.50.tar.gz && \
	tar -xvf /tmp/apache-tomcat-8.0.50.tar.gz -C /opt/tomcat --strip-components=1 && \
  rm $CATALINA_HOME/bin/*.bat && rm /tmp/apache-tomcat-8.0.50.tar.gz

COPY files/server.xml conf/
COPY files/catalina.sh bin/
COPY files/catalina.properties /opt/tomcat/conf/

RUN chmod ugo+x $CATALINA_HOME/bin/catalina.sh
RUN mkdir -p /opt/tomcat/shared/config

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
