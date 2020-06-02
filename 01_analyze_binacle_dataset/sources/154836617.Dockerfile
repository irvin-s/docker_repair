# RUN Solr Cloud Docker

FROM centos:7

Maintainer Lucas Bkian

# Yum #

RUN yum install -y wget tar python  krb5-libs krb5-workstation vim
RUN yum install -y libxslt-devel
RUN yum install -y snappy
RUN yum install -y python-devel
RUN yum install -y openssl-devel
RUN yum install -y libxslt-devel
RUN yum install -y cyrus-sasl-gssapi unzip
#RUN yum install -y java-1.8.0-openjdk-headless

# Java #

WORKDIR /tmp
RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.rpm"
RUN rpm -ivh jdk-8u161-linux-x64.rpm
ENV JAVA_HOME /usr/java/default

RUN curl  -k  -o solr.tar.gz  "{{source}}"
ENV JAVA_HOME /usr/java/default

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip"
RUN unzip jce_policy-8.zip
RUN cp UnlimitedJCEPolicyJDK8/US_export_policy.jar /usr/java/default/jre/lib/security/US_export_policy.jar
RUN cp UnlimitedJCEPolicyJDK8/local_policy.jar /usr/java/default/jre/lib/security/local_policy.jar

# Layout #

RUN mkdir -p {{user.home}}
RUN groupadd {{hadoop_group.name}} -g {{hadoop_group.gid}}
RUN groupadd {{group.name}} -g {{user.gid}}
RUN useradd {{user.name}} -u {{user.uid}} -g {{group.gid}} -m -d {{user.home}}
RUN usermod -a -G {{hadoop_group.name}},{{group.name}} {{user.name}}
#RUN usermod -a -G {{group.name}} {{user.name}}

# Install #

RUN mkdir -p {{install_dir}}
RUN tar -C {{install_dir}} -xzf /tmp/solr.tar.gz --strip-components 1
RUN ln -s {{install_dir}} {{latest_dir}}
RUN mkdir -p {{conf_dir}}
RUN ln -s {{latest_dir}}/conf {{conf_dir}}
RUN rm -rf {{latest_dir}}/bin/solr.in.sh
RUN ln -s {{conf_dir}}/solr.in.sh  {{latest_dir}}/bin/solr.in.sh

RUN mkdir -p {{pid_dir}}
RUN chown {{user.name}}:{{group.name}} -R {{pid_dir}}
RUN mkdir -p {{log_dir}}
RUN chown {{user.name}}:{{group.name}} -R {{log_dir}}
RUN chown {{user.name}}:{{group.name}} -R {{user.home}}
RUN ln -s {{conf_dir}}/solr.xml {{user.home}}/solr.xml 


RUN chown {{user.name}}:{{group.name}} -R {{install_dir}}

COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh
RUN chown {{user.name}}:{{group.name}} /docker_entrypoint.sh

USER root
RUN rm -f /tmp/solr.tar.gz

RUN echo 'ZONE="Europe/Paris"'> /etc/sysconfig/clock
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN rm -f /jdk-8u152-linux-x64.rpm

USER {{user.name}}
WORKDIR {{user.home}}
ENV TERM xterm-256color
RUN echo 'export JAVA_HOME="/usr/java/default' > /var/solr/data/.bash_profile


CMD ["./docker_entrypoint.sh"]
