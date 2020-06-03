# vim:set ft=dockerfile:
FROM centos:7

#JAVA install from https://github.com/Mashape/docker-java7/blob/master/Dockerfile
ENV JAVA_VERSION 8u112
ENV JAVA_BUILD_VERSION b15

RUN yum -y update && \
    curl --fail --location --insecure --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-${JAVA_BUILD_VERSION}/jdk-${JAVA_VERSION}-linux-x64.rpm" > /tmp/jdk-linux-x64.rpm && \
    yum -y install /tmp/jdk-linux-x64.rpm && \
    yum clean all && \
    rm -f /tmp/jdk-linux-x64.rpm


RUN alternatives --install /usr/bin/java java /usr/java/latest/bin/java 200000 && \
    alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000 && \
    alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000 && \
    alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000

ENV JAVA_HOME /usr/java/latest

#Tomcat install
#TODO choose latest 8.x version automatically as older versions are removed from mirrors (using libxml2-utils or pup or html-xml-utils)
ENV TOMCAT_VERSION 8.5.11

ENV TOMCAT_INSTALL /opt
RUN yum -y update && \
	yum -y install epel-release && \
	yum -y install jq && \
	yum clean all && \
	APACHE_URL=$(curl --fail --location --insecure "http://www.apache.org/dyn/closer.cgi?as_json=1" | jq --raw-output '.preferred') && \
	[[ -n "${APACHE_URL}" ]] && \
	curl --fail --location --insecure  "${APACHE_URL}tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz" > /tmp/tomcat.tar.gz && \
	mkdir -p "${TOMCAT_INSTALL}" && tar -xf /tmp/tomcat.tar.gz -C "${TOMCAT_INSTALL}" && \
	rm -f /tmp/tomcat.tar.gz && \
	ln -s /opt/apache-tomcat-${TOMCAT_VERSION} "${TOMCAT_INSTALL}/tomcat"

ENV CATALINA_HOME ${TOMCAT_INSTALL}/tomcat
ENV PATH ${PATH}:${JAVA_HOME}/bin:${CATALINA_HOME}/bin:${CATALINA_HOME}/scripts


#TODO add ARG var=value to reset cache if needed so that Linux can be updated

#
#MSTR
#
#Install required dependencies for Microstrategy 10.5 on CentOs 7
RUN yum -y update && \
	yum -y install \
	compat-libstdc++-33.i686 	compat-libstdc++-33.x86_64 \
	cups-libs.i686 		cups-libs.x86_64 \
	dbus-libs.i686 		dbus-libs.x86_64 \
	glibc.i686 			glibc.x86_64 \
	keyutils-libs.i686 	keyutils-libs.x86_64 \
	krb5-libs.i686 		krb5-libs.x86_64 \
	ksh.x86_64 \
	libcom_err.i686 	libcom_err.x86_64 \
	libgcc.i686 		libgcc.x86_64 \
	libICE.x86_64 \
	libselinux.i686 	libselinux.x86_64 \
	libSM.x86_64 \
	libstdc++.i686 		libstdc++.x86_64 \
	libX11-common.noarch \
	libX11.x86_64 \
	libXau.x86_64 \
	libxcb.x86_64 \
	libXext.x86_64 \
	libXt.x86_64 libXtst.x86_64 \
	motif.x86_64 \
	openssl-libs.i686 	openssl-libs.x86_64 \
	openssl098e.i686 	openssl098e.x86_64 \
	pcre.i686 			pcre.x86_64 \
	perl-core.x86_64 \
	perl-libs.x86_64 \
	perl.x86_64 \
	xz-libs.i686 		xz-libs.x86_64 \
	zlib.i686 			zlib.x86_64 \
	xmlstarlet \
	&& \
	yum clean all


ENV DEMO_INSTALL_HOME /mstr_demo
RUN mkdir -p "${DEMO_INSTALL_HOME}"

#MSTR copy files needed for MSTR install
COPY *.ini ${DEMO_INSTALL_HOME}/
COPY  *.sh ${DEMO_INSTALL_HOME}/
COPY  *.gz ${DEMO_INSTALL_HOME}/
COPY tomcat-users.xml ${CATALINA_HOME}/conf/

ENV MSTR_INSTALL_HOME /var/opt/MicroStrategy

#ENTRYPOINT ["/bin/bash","-c","${DEMO_INSTALL_HOME}/mstr_install.sh"]
