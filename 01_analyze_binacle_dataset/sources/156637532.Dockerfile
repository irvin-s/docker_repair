FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install sudo net-tools bash-completion vim wget iptables cronie; yum clean all

RUN useradd -r -d /usr/local/sonatype-work -s /sbin/nologin nexus \
        && cd /usr/local/src \
        && wget --no-check-certificate --no-cookies --header 'Cookie: oraclelicense=accept-securebackup-cookie' -c "$(curl -s https://lv.binarybabel.org/catalog/java/jdk8 |grep '&quot;rpm&quot;' |awk -F'&quot;' '{print $4}')" \
        && wget -c http://download.sonatype.com/nexus/3/latest-unix.tar.gz \
        && rpm -ivh jdk-*-linux-x64.rpm \
        && tar zxf latest-unix.tar.gz \
        && mv nexus-* /usr/local/nexus \
        && rm -rf /usr/local/src/*

VOLUME /usr/local/sonatype-work

COPY nexus.sh /nexus.sh
RUN chmod +x /nexus.sh

WORKDIR /usr/local/nexus

ENTRYPOINT ["/nexus.sh"]

EXPOSE 8081

CMD ["sudo", "-u", "nexus", "bin/nexus", "run"]

# docker build -t nexus .
# docker run -d --restart unless-stopped -p 8081:8081 -v /docker/nexus:/usr/local/sonatype-work --name nexus nexus
# docker run -it --rm nexus --help
