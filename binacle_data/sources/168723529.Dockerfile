FROM centos:latest
LABEL maintainer="fuhaiq@gmail.com"

########################################下载相关依赖###############################
RUN yum install -y net-tools openssh-clients openssh-server ntp perl which psmisc cyrus-sasl-plain cyrus-sasl-gssapi gcc python-devel cyrus-sasl* httpd libxml2 libxslt mod_ssl

#######################################生成SSH初始秘钥###########################################
RUN /usr/bin/ssh-keygen -A

#######################################替换时区##################################################
RUN sh -c '/bin/echo -e "y" | cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime'

#######################################配置JAVA环境##############################################
ADD jdk-8u191-linux-x64.tar.gz /opt
ENV JAVA_HOME /opt/jdk1.8.0_191

#######################################添加agent，parcel安装包，并配置agent环境##################
ADD cloudera-manager-centos7-cm5.16.1_x86_64.tar.gz /opt
RUN useradd --system --home=/opt/cm-5.16.1/run/cloudera-scm-server --no-create-home --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm
RUN mkdir -p /opt/cloudera/parcel-repo/
RUN chown -R cloudera-scm:cloudera-scm /opt/cloudera/parcel-repo
RUN mkdir -p /opt/cloudera/parcels
RUN chown -R cloudera-scm:cloudera-scm /opt/cloudera/parcels
RUN mkdir -p /usr/share/java
COPY mysql-connector-java.jar /usr/share/java
#install impala dir
#RUN mkdir -p /var/run/hdfs-sockets/dn
#RUN chown -R impala:impala /var/run/hdfs-sockets
RUN mkdir /opt/cm-5.16.1/run/cloudera-scm-agent
RUN rm -rf /opt/cm-5.16.1/etc/cloudera-scm-agent/config.ini
ADD config.ini /opt/cm-5.16.1/etc/cloudera-scm-agent
##### 挂载日记及数据目录，方便在容器外面操作
VOLUME ["/hadoop", "/opt/cm-5.16.1/log/cloudera-scm-agent"]

#######################################集成Kerberos##############################################
RUN yum -y install krb5-libs krb5-workstation
RUN rm -rf /etc/krb5.conf
COPY kerberos/krb5.conf /etc
COPY kerberos/jce/US_export_policy.jar $JAVA_HOME/jre/lib/security
COPY kerberos/jce/local_policy.jar $JAVA_HOME/jre/lib/security

######################################设置入口脚本###############################################
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
