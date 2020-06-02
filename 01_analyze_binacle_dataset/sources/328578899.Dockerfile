FROM tomcat:8.5-jre8-alpine

RUN rm -rf /usr/local/tomcat/webapps/ROOT* /usr/local/tomcat/webapps/docs* /usr/local/tomcat/webapps/examples* /usr/local/tomcat/webapps/host-manager*

COPY ./conf/tomcat/manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml

COPY ./conf/tomcat/bin/jrebel.jar /usr/local/tomcat/bin/
COPY ./conf/tomcat/bin/libjrebel64.so /usr/local/tomcat/bin/
COPY ./conf/tomcat/bin/setenv.sh /usr/local/tomcat/bin/

COPY ./conf/tomcat/conf/context.xml /usr/local/tomcat/conf/
COPY ./conf/tomcat/conf/tomcat-users.xml /usr/local/tomcat/conf/

COPY ./conf/tomcat/lib/logback.xml /usr/local/tomcat/lib/

COPY ./data/tomcat/lib/memcached.properties /usr/local/tomcat/lib/
COPY ./data/tomcat/lib/tabula.properties /usr/local/tomcat/lib/
COPY ./data/tomcat/lib/tabula-sso-config.xml /usr/local/tomcat/lib/

RUN wget -q -P /usr/local/tomcat/lib/ https://pkg.elab.warwick.ac.uk/ch.qos.logback/warwick-logging-1.1-all.jar && \
		wget -q -P /usr/local/tomcat/lib/ https://pkg.elab.warwick.ac.uk/oracle.com/ojdbc8.jar && \
		wget -q -P /usr/local/tomcat/lib/ http://central.maven.org/maven2/org/postgresql/postgresql/42.2.5/postgresql-42.2.5.jar