FROM outcoldman/splunk:6.3.1-forwarder
MAINTAINER Denis Gladkikh <docker-stats-splunk-forwarder@denis.gladkikh.email>

ENV DOCKER_VERSION 1.9.0
ENV SPLUNK_BACKUP_DOCKER_APP ${SPLUNK_BACKUP_DEFAULT_ETC}/etc/apps/docker

RUN apt-get update \
    && apt-get install -y wget jq \
    && mkdir -p ${SPLUNK_BACKUP_DOCKER_APP}/bin \
    && wget -qO ${SPLUNK_BACKUP_DOCKER_APP}/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION} \
    && chmod +x ${SPLUNK_BACKUP_DOCKER_APP}/bin/docker \
    && apt-get purge -y --auto-remove wget \
    && rm -rf /var/lib/apt/lists/*

ADD inputs.conf ${SPLUNK_BACKUP_DOCKER_APP}/default/
ADD props.conf ${SPLUNK_BACKUP_DOCKER_APP}/default/
ADD docker_inspect.sh ${SPLUNK_BACKUP_DOCKER_APP}/bin/
ADD docker_stats.sh ${SPLUNK_BACKUP_DOCKER_APP}/bin/
ADD docker_top.sh ${SPLUNK_BACKUP_DOCKER_APP}/bin/
ADD docker_events.sh ${SPLUNK_BACKUP_DOCKER_APP}/bin/

RUN chmod +x ${SPLUNK_BACKUP_DOCKER_APP}/bin/*.sh
