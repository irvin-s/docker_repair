FROM centos:7

MAINTAINER Lucas Bakalian <https://github.com/lucasbak>

WORKDIR /tmp/

#  UTILITIES TOOLS INSTALL  #

RUN yum clean all
RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y krb5-devel krb5-libs krb5-workstation vim
RUN yum install -y wget unzip

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jdk-8u77-linux-x64.rpm"
RUN rpm -ivh jdk-8u77-linux-x64.rpm
ENV JAVA_HOME /usr/java/default

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"
RUN unzip jce_policy-8.zip
RUN cp UnlimitedJCEPolicyJDK8/US_export_policy.jar /usr/java/default/jre/lib/security/US_export_policy.jar
RUN cp UnlimitedJCEPolicyJDK8/local_policy.jar /usr/java/default/jre/lib/security/local_policy.jar

# Livy Packages #

WORKDIR /var/lib
RUN wget {{source}}
RUN unzip livy-server-{{version}}.zip
RUN mkdir {{home}}
RUN mv livy-server-{{version}} {{home}}/livy
RUN mkdir -p {{conf_dir}}

# Livy Layout #

RUN groupadd {{user}} -g {{gid}}
RUN useradd {{user}} -u {{uid}} -g {{gid}} -d {{home}}
RUN chown -R {{user}}:{{group}} {{conf_dir}}
RUN chown -R {{user}}:{{group}} {{home}}/livy
RUN rm -rf {{home}}/livy/conf
RUN ln -sf {{conf_dir}} {{home}}/livy/

RUN echo 'ZONE="Europe/Paris"'> /etc/sysconfig/clock
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

USER {{user}}
ENTRYPOINT ["{{home}}/livy/bin/livy-server"]
