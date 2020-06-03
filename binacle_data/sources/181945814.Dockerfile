FROM centos/wildfly

COPY standalone.xml /opt/wildfly/standalone/configuration/
COPY mysql-connector-java-5.1.31-bin.jar /opt/wildfly/standalone/deployments/
COPY mysql-sample-ds.xml /opt/wildfly/standalone/deployments/

COPY javaee6angularjsmysql/target/javaee6angularjsmysql.war /opt/wildfly/standalone/deployments/
