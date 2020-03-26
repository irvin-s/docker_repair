FROM centos7/mesos-0.25.0-base
MAINTAINER upccup yyao@dataman-inc.com

ADD dataman_marathon.sh /usr/bin/

#add run_script
RUN yum install -y curl && \
#add dataman repo
    curl -o /etc/yum.repos.d/upccup.repo http://10.3.10.42/repos/CentOS/7/0/upccup.repo && \
#install
    yum -y install  marathon-0.13.1 && \
    yum clean all && \
    chmod 755 /usr/bin/dataman_marathon.sh && \
#logs
    mkdir -p /var/log/marathon && \
    ln -sf /dev/stdout /var/log/marathon/marathon.log

#CMD ["/usr/bin/dataman_marathon.sh"]
ENTRYPOINT ["/usr/bin/dataman_marathon.sh"]
