FROM jetty:9.4.2-jre8-alpine

ENV JETTY_WEBAPPS /var/lib/jetty/webapps
ENV BLAZEGRAPH_NAME blazegraph
ENV BLAZEGRAPH_VERSION 2_1_4
ENV BLAZEGRAPH_VERSION_URL https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_RELEASE_${BLAZEGRAPH_VERSION}/blazegraph.war

RUN apk --no-cache add openssl curl
RUN mkdir -p ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}/ && wget -O ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}.war $BLAZEGRAPH_VERSION_URL

RUN unzip ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}.war -d ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}/ && rm ${JETTY_WEBAPPS}/${BLAZEGRAPH_NAME}.war

COPY jetty-webapp.xml /var/lib/jetty/etc/

RUN chgrp -R 0 /var/lib/jetty && \
    chmod -R g=u /var/lib/jetty

COPY store.properties /tmp/import/store.properties
COPY store_users.properties /tmp/import/store_users.properties
COPY store_sandbox.properties /tmp/import/store_sandbox.properties
COPY create_namespaces.sh /tmp/import/create_namespaces.sh

USER jetty

# Imports the namespaces
RUN (cd /var/lib/jetty && java -jar /usr/local/jetty/start.jar &) && sh /tmp/import/create_namespaces.sh

CMD cd /var/lib/jetty && java -jar /usr/local/jetty/start.jar
