FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install sudo net-tools bash-completion vim wget make gcc pcre-devel; yum clean all

RUN useradd -r -s /sbin/nologin zabbix \
        && cd /usr/local/src \
        && wget -c https://sourceforge.net/projects/zabbix/files/latest/download?source=files -O zabbix.tar.gz

RUN cd /usr/local/src \
        && tar zxf zabbix.tar.gz \
        && cd /usr/local/src/zabbix-* \
        && ./configure --prefix=/usr/local/zabbix --enable-agent \
        && make install \
        && rm -rf /usr/local/src/* \
        && ln -s /usr/local/zabbix/sbin/zabbix_* /usr/bin/ \
        && ln -s /usr/local/zabbix/bin/* /usr/bin/

RUN echo -e '#!/bin/bash\nsed -i "s/=127.0.0.1/='\$1'/g" /usr/local/zabbix/etc/zabbix_agentd.conf 2>/dev/null\nexec sudo -u zabbix -H zabbix_agentd -f' >/zabbix.sh \
        && chmod +x /zabbix.sh

VOLUME /usr/local/zabbix/etc

EXPOSE 10050

ENTRYPOINT ["/zabbix.sh"]

CMD ["127.0.0.1"]

# docker build -t zabbix-agent .
# docker run -d --restart always --privileged --network=host --name zabbix-agent zabbix-agent 192.168.10.100
