FROM lsiobase/ubuntu:arm32v7-bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG LIBRESONIC_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs, thelamer"

# environment settings
ENV LIBRE_HOME="/app/libresonic" \
LIBRE_SETTINGS="/config" \
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
 echo "**** Get War ****" && \
 if [ -z ${LIBRESONIC_RELEASE+x} ]; then \
        LIBRESONIC_RELEASE=$(curl -sX GET "https://api.github.com/repos/Libresonic/libresonic/releases/latest" \
        | awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 mkdir -p /app/libresonic && \
 curl -o \
        /app/libresonic/libresonic.war -L \
        "https://github.com/Libresonic/libresonic/releases/download/${LIBRESONIC_RELEASE}/libresonic-${LIBRESONIC_RELEASE}.war"

# add local files
COPY root/ /

# ports and volumes
EXPOSE 4040
VOLUME /config /media /music /playlists /podcasts
