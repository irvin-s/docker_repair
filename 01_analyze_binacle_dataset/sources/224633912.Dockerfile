FROM centos7/mesos-0.24.0-base
MAINTAINER upccup yyao@dataman-inc.com

COPY libapparmor.so.1 /lib64/
COPY libseccomp.so.2 /lib64/

#create mesos dir
RUN mkdir -p /data/logs && \
    mkdir -p /data/mesos && \
    ln -s /lib64/libdevmapper.so.1.02 /lib64/libdevmapper.so.1.02.1 && \
    # support suse
    ln -s /lib64/libdevmapper.so.1.02 /lib64/libdevmapper.so.1.03

#CMD ["/usr/sbin/mesos-slave"]
ENTRYPOINT ["/usr/sbin/mesos-slave"]
