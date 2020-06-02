FROM ubuntu:14.04
MAINTAINER Peter Ericson <pdericson@gmail.com>

RUN apt-get update && apt-get install --no-install-recommends -y ca-certificates curl && rm -rf /var/lib/apt/lists/*

# https://github.com/Yelp/dumb-init
RUN curl -fLsS -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64 && chmod +x /usr/local/bin/dumb-init

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
echo deb http://repos.mesosphere.io/ubuntu trusty main > /etc/apt/sources.list.d/mesosphere.list && \
apt-get update && \
apt-get --no-install-recommends -y install mesos=0.28.0-2.0.16.ubuntu1404 && \
rm -rf /var/lib/apt/lists/*

CMD ["/usr/sbin/mesos-master"]

ENV MESOS_WORK_DIR /tmp/mesos

VOLUME /tmp/mesos

COPY entrypoint.sh /

ENTRYPOINT ["/usr/local/bin/dumb-init", "/entrypoint.sh"]
