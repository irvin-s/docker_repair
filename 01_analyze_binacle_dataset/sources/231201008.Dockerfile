# Dockerfile at https://github.com/wilsonmar/DevSecOps/master/blob/Jmeter/docker-jmeter
# Based on https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how

# 1 - FROM keyword defines the image baseline fetched from local cache or remote DockerHub:
FROM alpine:4.0
     # A valid Dockerfile must start with this primitive 3.6 and 4.0

# 2
LABEL maintainer="wilsonmar@gmail.com"

# 3 - Manually check whether the version downloaded from berkeley.edu has changed:
ARG JMETER_VERSION="3.3"

# 4 - Define environment variables used in the code to follow. Variables configured here persist when a container is run from the image:
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV MIRROR_HOST http://mirrors.ocf.berkeley.edu/apache/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_DOWNLOAD_URL http://repo1.maven.org/maven2/kg/apc
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/
ENV TZ America/Los_Angeles

# 5 - Run a single command for a more efficient single Docker layer:
RUN    apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
            && apk add --update openjdk8-jre tzdata curl unzip bash \
            && cp /usr/share/zoneinfo/UTC /etc/localtime \
            && echo "UTC" >  /etc/timezone \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies

# 6 - Download
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-dummy/0.2/jmeter-plugins-dummy-0.2.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-dummy-0.2.jar
RUN curl -L --silent ${JMETER_PLUGINS_DOWNLOAD_URL}/jmeter-plugins-cmn-jmeter/0.5/jmeter-plugins-cmn-jmeter-0.5.jar -o ${JMETER_PLUGINS_FOLDER}/jmeter-plugins-cmn-jmeter-0.5.jar

# 7
ENV PATH $PATH:$JMETER_BIN

# 8
COPY launch.sh /

#9
WORKDIR ${JMETER_HOME}

#10
ENTRYPOINT ["/launch.sh"]
