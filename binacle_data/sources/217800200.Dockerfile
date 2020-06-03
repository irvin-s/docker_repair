# See also https://hub.docker.com/_/tomcat/
FROM local/openjdk8

ENV CATALINA_HOME /usr/share/tomcat7
ENV CATALINA_BASE /var/lib/tomcat7
ENV CATALINA_TMPDIR $CATALINA_HOME/temp
ENV JRE_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV CLASSPATH $CATALINA_HOME/bin/bootstrap.jar:$CATALINA_HOME/bin/tomcat-juli.jar
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

RUN apt-get update && \
    apt-get install tomcat7 -y && \
    ln -s /var/lib/tomcat7/common $CATALINA_HOME/common && \
    ln -s /var/lib/tomcat7/server $CATALINA_HOME/server && \
    ln -s /var/lib/tomcat7/shared $CATALINA_HOME/shared && \
    ln -s /etc/tomcat7 $CATALINA_HOME/conf && \
    ln -s /var/log/tomcat7 $CATALINA_HOME/logs && \
    mkdir $CATALINA_HOME/temp && \
    chown -R tomcat7:tomcat7 $CATALINA_HOME /var/lib/tomcat7 /etc/tomcat7 && \
    cp /etc/default/tomcat7 /etc/default/tomcat7.bkup && \
    sed -e "s/^#*JAVA_HOME=.*$/JAVA_HOME=\/usr\/lib\/jvm\/java-8-openjdk-amd64/" /etc/default/tomcat7.bkup > /etc/default/tomcat7 && \
    rm /etc/default/tomcat7.bkup && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080
CMD ["catalina.sh", "run"]
