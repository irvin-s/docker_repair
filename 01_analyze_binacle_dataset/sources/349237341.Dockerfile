FROM centos:7
MAINTAINER Peter Ericson <pdericson@gmail.com>

# https://github.com/Yelp/dumb-init
RUN curl -fLsS -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64 && chmod +x /usr/local/bin/dumb-init

RUN rpm -i http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm && \
yum -y install mesos-0.28.1

CMD ["/usr/sbin/mesos-master"]

ENV MESOS_WORK_DIR /tmp/mesos

VOLUME /tmp/mesos

COPY entrypoint.sh /

ENTRYPOINT ["/usr/local/bin/dumb-init", "/entrypoint.sh"]
