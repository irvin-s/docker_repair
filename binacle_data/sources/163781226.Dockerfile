FROM centos:centos7

RUN yum install -y epel-release && \
    yum install -y wget lsof nano tar jq && \
    yum update -y bash && \
    mkdir -p /data && \
	mkdir -p /ww && \
	mkdir -p /backup && \
	yum clean all

CMD ["/ww/run"]
ADD ./ww /ww



