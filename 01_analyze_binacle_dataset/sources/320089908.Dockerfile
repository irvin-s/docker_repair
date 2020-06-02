################################################################################################
#####
##### BUILDER
#####
################################################################################################
FROM golang:1.10-alpine AS builder

#########################################################
## Install build dependencies
#########################################################

ARG APK_EDGE=${APK_EDGE:-"false"}
ARG APK_BUILD=${APK_BUILD:-"make git ca-certificates openssl mercurial"}

#### !!! Not used with this builder
# ARG USER=${RUNTIME_USER:-"app"}
# ARG USER_HOME=${USER_HOME:-"/app"}
# ARG DATA_HOME=${DATA_HOME:-"/data"}
# ARG INSTALL_HOME=${INSTALL_HOME:-"/install"}
# ARG SHARED_HOME=${SHARED_HOME:-"/shared"}
####

RUN apk add --no-cache --no-progress ${APK_BUILD}

#########################################################
## Copy source code in the container & build program
#########################################################

ARG SRC_VCS_URI=${SRC_VCS_URI:-"github.com/sniperkit/dataflowkit"}
ARG SRC_PATH_PREFIX=${SRC_PATH_PREFIX:-"cmd/fetch.d"}
ARG SRC_PATH_FULL="${GOPATH}/${SRC_VCS_URI}/${SRC_PATH_PREFIX}"

ARG APP_BINARY_NAME="${APP_BINARY_NAME:-"fetch.d"}"
ARG APP_BINARY_PATH_FULL="${APP_BINARY_PATH_FULL:-"${SRC_PATH_FULL}/${APP_BINARY_NAME}"}"
ARG APP_BINARY_PATH_BUILD="${APP_BINARY_PATH_BUILD:-"${APP_BINARY_PATH_FULL}/bin/${APP_BINARY_NAME}"}"

COPY .  ${SRC_PATH_FULL}
WORKDIR ${SRC_PATH_FULL}

RUN cd ${SRC_PATH_FULL} \
	&& pwd \
	&& ls -l \
	&& mkdir -p bin \
	&& go get -v -u ${SRC_VCS_URI} \
 	&& go build -v -o ${APP_BINARY_PATH_FULL}

################################################################################################
#####
##### RUNTIME
#####
################################################################################################
FROM alpine:3.7 AS runtime

#########################################################
# Install tini in /usr/local/sbin
#########################################################

ARG WITH_TINI=${WITH_TINI:-"true"}
ARG TINI_VERSION=${TINI_VERSION:-"0.17.0"}
ARG TINI_COMPILE=${TINI_COMPILE:-"muslc"}
ARG TINI_ARCH=${TINI_VERSION:-"amd64"}
ARG TINI_FILEPATH=${TINI_FILEPATH:-"/usr/local/sbin/tini"}

ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-${TINI_COMPILE}-${TINI_ARCH} ${TINI_FILEPATH}

#########################################################
# or Install gosu in /usr/local/sbin
#########################################################

ARG WITH_GOSU=${WITH_GOSU:-"false"}
ARG GOSU_VERSION=${GOSU_VERSION:-"1.10"}
ARG GOSU_ARCH=${GOSU_ARCH:-"amd64"}
ARG GOSU_FILEPATH=${GOSU_FILEPATH:-"/usr/local/sbin/gosu"}

# Install gosu in /usr/local/bin/gosu
ADD https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCH} ${GOSU_FILEPATH}

#########################################################
# Install runtime dependencies & create runtime user
#########################################################

# container - apk
ARG APK_EDGE=${APK_EDGE:-"false"}
ARG APK_RUNTIME=${APK_RUNTIME:-"ca-certificates git libssh2 openssl"}

# container - global

ARG OPT_DIR=${OPT_DIR:-"/opt"}

#### !!! Not used with this runtime 
# ARG INSTALL_HOME=${INSTALL_HOME:-"/install"}

# container - user
ARG APP_USER=${APP_USER:-"snk"}

# container - app
ARG APP_NAME=${APP_NAME:-"dev-assitant"}
ARG APP_PORT=${APP_PORT:-"2312"}

ARG APP_DIR=${APP_DIR:-"sniperkit"}
ARG APP_SUBDIRS=${APP_SUBDIRS:-"bin config data"}
ARG APP_HOME=${APP_HOME:-"${OPT_DIR}/${APP_DIR}"}

ARG APP_CONF_PREFIX=${APP_CONF_PREFIX:-"${APP_HOME}/conf"}
ARG APP_CONF=${APP_CONF:-"${APP_CONF_PREFIX}/config.yml"}

ARG APP_DATA=${APP_DATA:-"${APP_HOME}/data"}
ARG APP_BIN_PREFIX=${APP_BIN_PREFIX:-"${APP_HOME}/bin"}
ARG APP_BIN=${APP_BIN:-"${APP_BIN_PREFIX}/${APP_NAME}"}

RUN \
	if [ -f "${GOSU_FILEPATH}" ]; then \
		chmod +x ${GOSU_FILEPATH}; \
	fi && \
	\
	if [ -f "${TINI_FILEPATH}" ]; then \
		chmod +x ${TINI_FILEPATH}; \
	fi && \
	\
	if [ $ALPINE_EDGE == "true" ]; then \
 		echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories; \
 	fi \
 	\
	 	&& mkdir -p ${APP_HOME} \
 		&& apk --no-cache --no-progress add ${APK_RUNTIME} \
 		&& adduser -D app -h /data -s /bin/sh \
 		&& su ${APP_USER} -c 'cd ${APP_HOME}; mkdir -p ${APP_SUBDIRS}'


# Switch to user context
USER ${APP_USERNAME}
WORKDIR ${APP_HOME}

# Copy binary to /opt/app/bin
COPY --from=builder ${APP_BINARY_PATH_FULL} ${APP_BIN}

#### !!! Not used with this runtime 
# COPY config.json /opt/app/config/config.yaml

#### !!! Not used with this runtime 
# COPY config.json /opt/app/config/config.json

ENV PATH $PATH:${APP_BIN}

# Container configuration
EXPOSE ${APP_PORT}
VOLUME ["${APP_DATA}"]

# ENTRYPOINT ["tini", "-g", "--"]
# ENTRYPOINT ["gosu", "${APP_USER}", "${APP_BIN}"]
# CMD ["${APP_BIN}", "-conf_dir=${APP_CONF}"]

CMD ["${APP_BIN}"]
