FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG AIRSONIC_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ENV AIRSONIC_HOME="/app/airsonic" \
AIRSONIC_SETTINGS="/config" \
LANG="C.UTF-8"

RUN \
 echo "**** install runtime packages ****" && \
 apt-get update && \
 apt-get install -y \
	--no-install-recommends \
	ca-certificates \
	ffmpeg \
	flac \
	fontconfig \
	lame \
	openjdk-8-jre-headless \
	ttf-dejavu && \
 echo "**** fix XXXsonic status page ****" && \
 find /etc -name "accessibility.properties" -exec rm -fv '{}' + && \
 find /usr -name "accessibility.properties" -exec rm -fv '{}' + && \
 echo "**** install airsonic ****" && \
 if [ -z ${AIRSONIC_RELEASE+x} ]; then \
 	AIRSONIC_RELEASE=$(curl -sX GET "https://api.github.com/repos/airsonic/airsonic/releases/latest" \
        | awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p \
	${AIRSONIC_HOME} && \
 curl -o \
 ${AIRSONIC_HOME}/airsonic.war -L \
	"https://github.com/airsonic/airsonic/releases/download/${AIRSONIC_RELEASE}/airsonic.war" && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 4040
VOLUME /config /media /music /playlists /podcasts
