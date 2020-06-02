# Based on https://hub.docker.com/_/tomcat/, official Tomcat image
FROM tomcat:8.5
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

ENV TERM xterm

#
# Configure Tomcat per https://knowledge.opentext.com/knowledge/piroot/otds/v160000/otds-iwc/en/html/jsframe.htm?igd-configtomcat
# urandom fixes SecureRandom taking 10 minutes to generate a session ID on some systems
#

ENV CATALINA_OPTS '-Xmx1024M -Djava.security.egd=file:/dev/./urandom'

COPY server.xml $CATALINA_HOME/conf/server.xml

COPY logging.properties $CATALINA_HOME/conf/logging.properties


#
# Install OpenText Directory Services
#

# TODO: Try not to run as root? But Tomcat itself seems to be running as root...

COPY otds-response.properties /usr/local/tomcat/opentext-directory-services-installer/

# Based on http://stackoverflow.com/a/26156895/223225 and http://jonathan.bergknoff.com/journal/building-good-docker-images
ARG OBJECTS_ROOT_URL
RUN echo 'Copying OpenText Directory Services installation files into this image...' \
	&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2/OTDS-1620-LNX6.tar \
		| tar --extract --strip-components=1 --directory /usr/local/tomcat/opentext-directory-services-installer/ \
	# Fix “bad substitution” errors; http://stackoverflow.com/a/20616103/223225, http://stackoverflow.com/a/1585810/223225
	&& find /usr/local/tomcat/opentext-directory-services-installer/ -type f -exec sed -i 's|#! /bin/sh|#! /bin/bash|' {} + \
	&& echo 'Installing OpenText Directory Services...' \
	&& ln --symbolic --force /dev/stdout /usr/local/tomcat/logs/otds-installer.log \
	&& /usr/local/tomcat/opentext-directory-services-installer/setup -rf /usr/local/tomcat/opentext-directory-services-installer/otds-response.properties -qi -l /usr/local/tomcat/logs/otds-installer.log \
	&& echo 'Removing install files...' \
	&& rm -rf /usr/local/tomcat/opentext-directory-services-installer

# If we’re not installing on start, add some files that get created as a result of OpenText Media Management installation
ARG DOCKER_MODE
ENV INSTALLATION_FILES_SNAPSHOT 2017-04-12-20-55
RUN if [ ! "$DOCKER_MODE" = 'install-on-start' ]; then \
		echo 'Copying files into this image created by installation of OpenText Media Management...' \
		&& rm /usr/local/OTDS/opendj/config/hostname \
		&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2-post-install/opentext-directory-services-installed-files-$INSTALLATION_FILES_SNAPSHOT.tar.gz \
			| tar --extract --gunzip --directory /; \
	fi

# Forward log to Docker log collector, based on https://github.com/nginxinc/docker-nginx/blob/master/mainline/jessie/Dockerfile
RUN ln --symbolic --force /dev/stdout /usr/local/tomcat/logs/otds.log \
	&& ln --symbolic --force /dev/stdout /usr/local/OTDS/opendj/logs/access \
	&& ln --symbolic --force /dev/stderr /usr/local/OTDS/opendj/logs/errors


ENV OTDS_HOME /usr/local/OTDS
COPY entrypoint.sh /
COPY configure.sh /docker/
COPY create-installed-files-archive.sh /docker/
COPY create-test-data-archive.sh /docker/

ENTRYPOINT ["/entrypoint.sh"]
