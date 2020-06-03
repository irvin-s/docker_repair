# See https://hub.docker.com/r/jrottenberg/ffmpeg/ and https://github.com/jrottenberg/ffmpeg
FROM jrottenberg/ffmpeg:3-centos
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

#
# Dependencies
# Unzip for below command; Java 8 JDK per http://stackoverflow.com/a/20685838/223225; postgresql for the psql client used in entrypoint.sh
#
ENV JAVA_VERSION 1.8.0

# iputils causes `cap_set_file` error, https://github.com/docker/docker/issues/6980; but we don’t need it
RUN yum remove -y iputils \
	&& yum update -y \
	&& yum install -y bsdtar unzip java-$JAVA_VERSION-openjdk java-$JAVA_VERSION-openjdk-devel postgresql \
	&& yum clean all

ENV JAVA_HOME /usr/lib/jvm/jre-$JAVA_VERSION-openjdk

#
# Install FFmpeg Transcode service per https://knowledge.opentext.com/knowledge/piroot/medmgt/v160200/medmgt-igd/en/html/run-ffmpeg-external.htm
#
ARG OBJECTS_ROOT_URL
RUN echo 'Copying FFmpeg Transcode service installation files into the image...' \
	# Unfortunately the installation files we need are within the OTMM overall .iso, so we need to download the whole thing and then only keep what we need
	&& mkdir /opt/opentext-media-management-installer \
	&& curl --retry 999 --retry-max-time 0 -C - --show-error --location $OBJECTS_ROOT_URL/opentext-media-management-16.2/mediamgmt_16.2_linux.iso \
		| bsdtar --extract --preserve-permissions --file - --directory /opt/opentext-media-management-installer/ \
	&& mv /opt/opentext-media-management-installer/FFMPEG /opt/ffmpeg-transcoder-installer \
	&& rm -rf /opt/opentext-media-management-installer

COPY ffmpeg_config.txt /opt/ffmpeg-installer/
RUN echo 'Installing FFmpeg Transcode service...' \
	&& /opt/ffmpeg-transcoder-installer/Disk1/InstData/VM/install.bin -i silent -f /opt/ffmpeg-installer/ffmpeg_config.txt \
	&& rm -rf /opt/ffmpeg-transcoder-installer

WORKDIR /opt/ffmpeg-transcoder
ENV FFMPEG_HOME /opt/ffmpeg-transcoder

ENV PATH "$PATH:$FFMPEG_HOME/bin:$FFMPEG_HOME/ant/bin"

COPY transcoder.properties /opt/ffmpeg-transcoder/conf/transcoder.properties


# Forward log to Docker log collector, based on https://github.com/nginxinc/docker-nginx/blob/master/mainline/jessie/Dockerfile
RUN ln --symbolic --force /dev/stdout /opt/ffmpeg-transcoder/logs/ffmpeg-transcoder.log \
	&& ln --symbolic --force /dev/stdout /opt/ffmpeg-transcoder/logs/installation/FFMPEG.out \
	&& ln --symbolic --force /dev/stderr /opt/ffmpeg-transcoder/logs/installation/FFMPEG.err

# Based on https://github.com/docker-library/wordpress/blob/master/apache/Dockerfile
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
