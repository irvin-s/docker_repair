# This image provides a base for building and running Apache-Tomcat applications.
# It builds using maven and runs the resulting artifacts on Apache-Tomcat

FROM openshift/base-centos7

MAINTAINER Sarcouy <sarcouy@protonmail.com>

EXPOSE 8080

ENV TOMCAT_VERSION=7.0.77 \
    TOMCAT_MAJOR=7 \
    MAVEN_VERSION=3.3.9 \
    TOMCAT_DISPLAY_VERSION=7 \
    CATALINA_HOME=/tomcat \
    JAVA="java-1.7.0-openjdk java-1.7.0-openjdk-devel" \
    JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8 \
    POM_PATH=.

LABEL io.k8s.description="Platform for building and running Java applications on Apache-Tomcat 7.0.77" \
      io.k8s.display-name="Apache-Tomcat 7.0.77" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,tomcat,tomcat7" \
      io.openshift.s2i.destination="/opt/s2i/destination"

# Install Maven, Tomcat, Java
RUN INSTALL_PKGS="tar unzip bc which lsof $JAVA" && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    (curl -v https://www.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | \
    tar -zx -C /usr/local) && \
    ln -sf /usr/local/apache-maven-$MAVEN_VERSION/bin/mvn /usr/local/bin/mvn && \
    mkdir -p $HOME/.m2 && \
    mkdir -p /tomcat && \
    (curl -v https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz | tar -zx --strip-components=1 -C /tomcat) && \
    mkdir -p /opt/s2i/destination

# Add s2i tomcat customizations
ADD ./contrib/settings.xml $HOME/.m2/

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN chown -R 1001:0 /tomcat && chown -R 1001:0 $HOME && \
    chmod -R ug+rwx /tomcat && \
    chmod -R g+rw /opt/s2i/destination

USER 1001

CMD $STI_SCRIPTS_PATH/usage
