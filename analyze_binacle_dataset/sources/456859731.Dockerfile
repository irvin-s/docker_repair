# Based on https://hub.docker.com/r/jboss/wildfly/ and https://github.com/jboss-dockerfiles/wildfly/blob/9.0.2.Final/Dockerfile

FROM jboss/wildfly:9.0.2.Final
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

USER root
ENV TERM xterm


#
# Install OpenText Media Management dependencies
#
# - ImageMagick, per http://webapp.opentext.com/piroot/medmgt/v160200/medmgt-igd/en/html/aid-34.htm
# - PostgresQL, just the client libraries and not the server, so we get the psql command used in entrypoint.sh; note that the 9.4 below must match the version in the postgres Dockerfile
# - X Virtual Framebuffer, per http://webapp.opentext.com/piroot/medmgt/v160200/medmgt-igd/en/html/x-virtual.htm
# - MediaInfo, per https://knowledge.opentext.com/knowledge/piroot/medmgt/v160000/medmgt-igd/en/html/jsframe.htm?instl-media-info and http://stackoverflow.com/a/27320898/223225
# - Exiftool, to work with image EXIF headers; http://xmodulo.com/view-or-edit-pdf-and-image-metadata-from-command-line-on-linux.html
# - Screen, to create persistent terminal sessions that can be attached or detached from; https://www.gnu.org/software/screen/
RUN yum clean all \
	&& yum --enablerepo extras install -y epel-release rpmforge-release \
	&& curl --retry 999 --retry-max-time 0 -C - --show-error --location http://rpms.famillecollet.com/enterprise/remi-release-7.rpm --output remi-release-7.rpm \
	&& rpm --verbose --hash --upgrade remi-release-7*.rpm \
	&& rm remi-release-7.rpm \
	&& yum --enablerepo=remi install -y ImageMagick7 \
	&& curl --retry 999 --retry-max-time 0 -C - --show-error --location https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm --output pgdg-centos94-9.4-3.noarch.rpm \
	&& rpm --verbose --hash --upgrade pgdg-centos94-9.4-3.noarch.rpm \
	&& rm pgdg-centos94-9.4-3.noarch.rpm \
	# iputils causes `cap_set_file` error, https://github.com/docker/docker/issues/6980; but we don’t need it
	&& yum remove -y iputils \
	&& yum update -y \
	&& yum install -y xorg-x11-server-Xvfb mediainfo postgresql94 perl-Image-ExifTool screen \
	&& yum clean all

# Copy patched CentOS `/etc/init.d/functions` file into this image, as $TEAMS_HOME/bin/mediamanagement-process-manager and indexer-process-manager are expecting it
COPY functions.sh /etc/init.d/functions


#
# Copy install files, or installed files, for OpenText Media Management
# See https://knowledge.opentext.com/knowledge/piroot/medmgt/v160000/medmgt-igd/en/html/jsframe.htm?aid-32
#

# Copy in the installer config file
COPY mediamanagement_config.txt /opt/

# Based on http://stackoverflow.com/a/26156895/223225 and http://jonathan.bergknoff.com/journal/building-good-docker-images
ARG DOCKER_MODE
ARG OBJECTS_ROOT_URL
ENV INSTALLATION_FILES_SNAPSHOT 2017-04-12-20-55
RUN if [ "$DOCKER_MODE" = 'install-on-start' ]; then \
		echo 'Copying OpenText Media Management installation files into the image...' \
		&& mkdir /opt/opentext-media-management-installer \
		&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2/mediamgmt_16.2_linux.iso \
			| bsdtar --extract --preserve-permissions --file - --directory /opt/opentext-media-management-installer/; \
	else \
		echo 'Copying OpenText Media Management post-installation application files into the image...' \
		&& rm /opt/mediamanagement_config.txt \
		&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2-post-install/opentext-media-management-installed-files-$INSTALLATION_FILES_SNAPSHOT.tar.gz \
			| tar --extract --ungzip --directory /; \
	fi

# Based on https://github.com/docker-library/wordpress/blob/master/apache/Dockerfile
COPY entrypoint.sh /
COPY install.sh /docker/
COPY patch.sh /docker/
COPY create-installed-files-archive.sh /docker/
COPY create-test-data-archive.sh /docker/
COPY configure.sh /docker/
COPY deploy.sh /docker/

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 11090
