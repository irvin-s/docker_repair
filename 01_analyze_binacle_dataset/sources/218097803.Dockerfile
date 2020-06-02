FROM anapsix/alpine-java:jdk7

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.38
ENV TOMCAT_TGZ_URL https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

RUN cd /tmp \
    && apk --no-cache --update --virtual build-dependencies add openssl \
    && rm -f /var/cache/apk/* \
    && wget ${TOMCAT_TGZ_URL} \
    && tar zxvf apache-tomcat-$TOMCAT_VERSION.tar.gz \
    && mkdir -p /opt \
    && mv apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
    && rm -rf apache-tomcat-${TOMCAT_VERSION} \
    && rm -rf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && awk '/<\/tomcat-users>/ {print "  <user username=\"tomcat\" password=\"tomcat\" roles=\"manager-gui,manager-script,agent\"/>"} {print $0}' \
           /opt/tomcat/conf/tomcat-users.xml > /tmp/tomcat-users.xml \
    && mv /tmp/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml \
    && awk '/^common\.loader/ {print "common.loader=\"${catalina.base}/lib\",\"${catalina.base}/lib/*.jar\",\"${catalina.home}/lib\",\"${catalina.home}/lib/*.jar\",\"${catalina.home}/lib/ext\",\"${catalina.home}/lib/ext/*.jar\""} ! /^common\.loader/ {print $0}' \
          /opt/tomcat/conf/catalina.properties > /tmp/catalina.properties \
    && mv /tmp/catalina.properties /opt/tomcat/conf/catalina.properties \
    && awk '/JPDA_ADDRESS="localhost:8000"/ {print "    JPDA_ADDRESS=\"8000\""} ! /JPDA_ADDRESS="localhost:8000"/ {print $0}' /opt/tomcat/bin/catalina.sh > /tmp/catalina.sh \
    && mv /tmp/catalina.sh /opt/tomcat/bin/catalina.sh \
    && chmod +x /opt/tomcat/bin/catalina.sh \
    && apk del build-dependencies

ADD ./setenv.sh /opt/tomcat/bin

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
