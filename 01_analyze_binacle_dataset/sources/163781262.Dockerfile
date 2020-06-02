FROM lenz/whaleware

EXPOSE 8080

RUN touch /var/lib/rpm/* && yum install -y yum-plugin-ovl
RUN yum install -y wget lsof nano tar jq  && \
    wget -P /etc/yum.repos.d http://yum.loway.ch/loway.repo && \
    yum install -y mysql mysql-server && \
    yum install -y queuemetrics

ADD ./ww /ww

