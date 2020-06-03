FROM lsiobase/python:arm64v8-3.9

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HYDRA_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN \
 echo "**** install app ****" && \
 mkdir -p \
	/app/hydra && \
 if [ -z ${HYDRA_RELEASE+x} ]; then \
	HYDRA_RELEASE=$(curl -sX GET "https://api.github.com/repos/theotherp/nzbhydra/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
	/tmp/hydra.tar.gz -L \
	"https://github.com/theotherp/nzbhydra/archive/${HYDRA_RELEASE}.tar.gz" && \
 tar xf /tmp/hydra.tar.gz -C \
	/app/hydra --strip-components=1 && \
 echo "**** Cleanup ****" && \
 rm -Rf /tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 5075
# WORKDIR /config/hydra
VOLUME /config /downloads
