FROM hotswapagent/hotswap-vm
MAINTAINER hotwapagent.org
ENV ARCHIVE apache-tomcat-8.5.29
ENV INSTALL_DIR /opt
ENV SERVER_HOME ${INSTALL_DIR}/${ARCHIVE}
RUN curl -o ${SERVER_HOME}.zip -L http://apache.mirror.iphh.net/tomcat/tomcat-8/v8.5.29/bin/apache-tomcat-8.5.29.zip
RUN unzip ${SERVER_HOME}.zip -d /opt
RUN chmod a+x ${SERVER_HOME}/bin/catalina.sh
ENV DEPLOYMENT_DIR ${SERVER_HOME}/webapps/
ENTRYPOINT ${SERVER_HOME}/bin/catalina.sh run
EXPOSE 8080
