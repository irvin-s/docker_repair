FROM centos7/mesos-0.23.0-base
MAINTAINER upccup yyao@dataman-inc.com

#create mesos documents
RUN mkdir -p /data/logs && \
    mkdir -p /data/mesos

#CMD ["/usr/sbin/mesos-master"]
ENTRYPOINT ["/usr/sbin/mesos-master"]
