FROM hotswapagent/hotswap-vm
MAINTAINER hotwapagent.org
ENV ARCHIVE apache-tomee-plume-7.0.4
ENV INSTALL_DIR /opt
ENV SERVER_HOME ${INSTALL_DIR}/${ARCHIVE}
RUN curl -o ${SERVER_HOME}.zip -L http://repo.maven.apache.org/maven2/org/apache/tomee/apache-tomee/7.0.5/apache-tomee-7.0.5-plume.zip \
    && unzip ${SERVER_HOME}.zip -d /opt \
    && rm ${SERVER_HOME}.zip
ENV DEPLOYMENT_DIR ${SERVER_HOME}/webapps/
ENTRYPOINT ${SERVER_HOME}/bin/catalina.sh run
EXPOSE 8080
