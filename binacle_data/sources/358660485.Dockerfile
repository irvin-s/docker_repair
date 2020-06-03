FROM lsiobase/python:arm64v8-3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG MYLAR_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install system packages ****" && \
 apk add --no-cache \
	git \
	nodejs && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	comictagger \
	configparser \
	html5lib \
	requests \
	tzlocal && \
 echo "**** install app ****" && \
 if [ -z ${MYLAR_COMMIT+x} ]; then \
	MYLAR_COMMIT=$(curl -sX GET https://api.github.com/repos/evilhero/mylar/commits/master \
	| awk '/sha/{print $4;exit}' FS='[""]'); \
 fi && \
 git clone https://github.com/evilhero/mylar.git /app/mylar && \
 cd /app/mylar && \
 git checkout ${MYLAR_COMMIT} && \
 echo "**** cleanup ****" && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /comics /downloads
EXPOSE 8090
