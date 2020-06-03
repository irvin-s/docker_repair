FROM       dockerfile/ubuntu
MAINTAINER Hardy Ferentschik <hardy@hibernate.org>

# Install Java 7
RUN        echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
           echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
           add-apt-repository -y ppa:webupd8team/java && \
           apt-get update && \
           apt-get install -y oracle-java7-installer

# Install systat tools
RUN        apt-get install -y sysstat

# Add the WildFly distribution to /opt
RUN        cd /opt && curl http://download.jboss.org/wildfly/8.1.0.Final/wildfly-8.1.0.Final.tar.gz | tar zx

# Make sure the distribution is available from a well-known place
RUN        ln -s /opt/wildfly-8.1.0.Final /opt/wildfly

# Create the wildfly user and group
RUN        groupadd -r wildfly -g 433 && useradd -u 431 -r -g wildfly -d /opt/wildfly -s /bin/bash -c "WildFly user" wildfly

# Create Wildfly admin user
RUN        /opt/wildfly/bin/add-user.sh admin admin --silent

# Change the owner of the /opt/wildfly directory
RUN        chown -R wildfly:wildfly /opt/wildfly/*
RUN        chmod -R 755 /opt/wildfly

# Run everything below as the wildfly user
USER       wildfly

# Replace EL API for demo purposes (the patched version does not use a soft reference)
# https://issues.jboss.org/browse/AS7-3736
ADD        jboss-el-api_3.0_spec-1.0.5.Final-SNAPSHOT.jar /opt/wildfly/modules/system/layers/base/javax/el/api/main/jboss-el-api_3.0_spec-1.0.5.Final-SNAPSHOT.jar
RUN        rm /opt/wildfly/modules/system/layers/base/javax/el/api/main/jboss-el-api_3.0_spec-1.0.3.Final.jar
RUN        sed -i "s/jboss-el-api_3.0_spec-1.0.3.Final.jar/jboss-el-api_3.0_spec-1.0.5.Final-SNAPSHOT.jar/g" /opt/wildfly/modules/system/layers/base/javax/el/api/main/module.xml

WORKDIR    /opt

# Set the default command to run on boot
# This will boot WildFly in the standalone mode and bind to all interface
CMD        ["/opt/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

ENV       JAVA_HOME /usr/lib/jvm/java-7-oracle
ENV       JBOSS_HOME /opt/wildfly
ENV       JAVA_OPTS -server \
          -Xms64m -Xmx512m -XX:MaxPermSize=256m \
          -Djava.net.preferIPv4Stack=true \
          -Djava.awt.headless=true \
          -XX:+UnlockCommercialFeatures -XX:+FlightRecorder \
          -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled \
          -Dcom.sun.management.jmxremote=true \
          -Dcom.sun.management.jmxremote.port=7091 \
          -Dcom.sun.management.jmxremote.authenticate=false \
          -Dcom.sun.management.jmxremote.ssl=false \
          -Dcom.sun.management.jmxremote.rmi.port=7091 \
          -Djava.rmi.server.hostname=192.168.59.103 \
          -Djboss.modules.system.pkgs=org.jboss.byteman,org.jboss.logmanager \
          -Djava.util.logging.manager=org.jboss.logmanager.LogManager \
          -Xbootclasspath/p:$JBOSS_HOME/modules/system/layers/base/org/jboss/logmanager/main/jboss-logmanager-1.5.2.Final.jar \
          -Djboss.socket.binding.port-offset=100

EXPOSE 1099 7000 7091 8180 10090 10099

