FROM alpine:3.4

MAINTAINER Stefan Prodan

ENV NEXUS_VERSION="3.2.1-01" \
    NEXUS_DATA="/nexus-data" \
    JAVA_MIN_MEM="1200M" \
    JAVA_MAX_MEM="1200M" \
    JKS_PASSWORD="changeit"

RUN set -x \
    && apk --no-cache add \
        openjdk8-jre-base \
        openssl \
        su-exec \
    && mkdir "/opt" \
    && wget -qO - "https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz" \
    | tar -zxC "/opt" \
    && adduser -S -h ${NEXUS_DATA} nexus \
	&& sed \
		-e "s|-Xms1200M|-Xms${JAVA_MIN_MEM}|g" \
		-e "s|-Xmx1200M|-Xmx${JAVA_MAX_MEM}|g" \
		-e "s|karaf.home=.|karaf.home=/opt/nexus-${NEXUS_VERSION}|g" \
		-e "s|karaf.base=.|karaf.base=/opt/nexus-${NEXUS_VERSION}|g" \
		-e "s|karaf.etc=etc|karaf.etc=/opt/nexus-${NEXUS_VERSION}/etc|g" \
		-e "s|java.util.logging.config.file=etc|java.util.logging.config.file=/opt/nexus-${NEXUS_VERSION}/etc|g" \
		-e "s|-XX:LogFile=../sonatype-work/nexus3/log/jvm.log|-XX:LogFile=${NEXUS_DATA}/log/jvm.log|g" \
		-e "s|karaf.data=../sonatype-work/nexus3|karaf.data=${NEXUS_DATA}|g" \
		-e "s|java.io.tmpdir=../sonatype-work/nexus3/tmp|java.io.tmpdir=${NEXUS_DATA}/tmp|g" \
		-i "/opt/nexus-${NEXUS_VERSION}/bin/nexus.vmoptions" \
	&& mkdir -p "${NEXUS_DATA}" \
	&& chown -R nexus "${NEXUS_DATA}"

EXPOSE 8081 5000

WORKDIR "/opt/nexus-${NEXUS_VERSION}"

VOLUME ${NEXUS_DATA}

CMD ["su-exec", "nexus", "bin/nexus", "run"]
