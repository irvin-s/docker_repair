FROM java:7
MAINTAINER Leandro Cesquini Pereira <leandro.cesquini@gmail.com>

ENV BISERVER_VERSION 5.3
ENV BISERVER_TAG 5.3.0.0-213
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64
ENV PENTAHO_HOME /pentaho
ENV PENTAHO_JAVA_HOME $JAVA_HOME
ENV CATALINA_BASE $PENTAHO_HOME/biserver-ce/tomcat
ENV CATALINA_HOME $PENTAHO_HOME/biserver-ce/tomcat
ENV CATALINA_TMPDIR $PENTAHO_HOME/biserver-ce/tomcat/temp
ENV CLASSPATH $PENTAHO_HOME/biserver-ce/tomcat/bin/bootstrap.jar 
ENV CATALINA_OPTS=""
ENV PATH $PENTAHO_HOME/biserver-ce:$PATH
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y curl locales zip unzip netcat dnsutils postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV TIMEZONE "America/Sao_Paulo"
ENV LOCALE "en_US.UTF-8 UTF-8"
ENV LANG "en_US.utf8"

RUN echo $TIMEZONE > /etc/timezone && \
    echo $LOCALE >> /etc/locale.gen && \
    locale-gen && \
    dpkg-reconfigure locales && \
    dpkg-reconfigure -f noninteractive tzdata

RUN /usr/bin/curl -SL "http://sourceforge.net/projects/pentaho/files/Business%20Intelligence%20Server/${BISERVER_VERSION}/biserver-ce-${BISERVER_TAG}.zip/download" -o /tmp/biserver-ce-${BISERVER_TAG}.zip --retry 3 -C -

RUN /usr/bin/unzip -q /tmp/biserver-ce-${BISERVER_TAG}.zip -d $PENTAHO_HOME && \
    rm -f /tmp/biserver-ce-${BISERVER_TAG}.zip && \
    rm -f $PENTAHO_HOME/biserver-ce/promptuser.sh && \
    mkdir $PENTAHO_HOME/conf && \
    chmod +x $PENTAHO_HOME/biserver-ce/start-pentaho.sh && \
    sed -i -e 's/\(exec ".*"\) start/\1 run/' $PENTAHO_HOME/biserver-ce/tomcat/bin/startup.sh

COPY conf $PENTAHO_HOME/conf
COPY entrypoint.sh /entrypoint.sh

VOLUME /pentaho-data

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]
