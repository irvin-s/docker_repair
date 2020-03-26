FROM lenz/whaleware

EXPOSE 8080

# Workaround for RPM issues before Centos 6.8
RUN yum install -y yum-plugin-ovl || true

RUN yum install -y wget lsof nano tar jq mysql && \
    wget -P /etc/yum.repos.d http://yum.loway.ch/loway.repo && \
    yum install -y queuemetrics-tomcat mysql-connectorj-java mysql mysql-server && \
    yum install -y wombat

ADD ./ww /ww

