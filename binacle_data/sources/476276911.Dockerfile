FROM        control_your_jvm/wildfly-8.1.0.final:non-leaking
MAINTAINER  Hardy Ferentschik <hardy@hibernate.org>

# Relace Validator implementation with the leaking version
ADD         hibernate-validator-cdi-5.0.1.Final.jar /opt/wildfly/modules/system/layers/base/org/hibernate/validator/cdi/main/hibernate-validator-cdi-5.0.1.Final.jar
RUN         rm /opt/wildfly/modules/system/layers/base/org/hibernate/validator/cdi/main/hibernate-validator-cdi-5.1.0.Final.jar
RUN         sed -i "s/5.1.0.Final/5.0.1.Final/g" /opt/wildfly/modules/system/layers/base/org/hibernate/validator/cdi/main/module.xml

ADD         hibernate-validator-5.0.1.Final.jar /opt/wildfly/modules/system/layers/base/org/hibernate/validator/main/hibernate-validator-5.0.1.Final.jar
RUN         rm /opt/wildfly/modules/system/layers/base/org/hibernate/validator/main/hibernate-validator-5.1.0.Final.jar
RUN         sed -i "s/5.1.0.Final/5.0.1.Final/g" /opt/wildfly/modules/system/layers/base/org/hibernate/validator/main/module.xml
