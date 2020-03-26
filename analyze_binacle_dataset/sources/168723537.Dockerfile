FROM centos:latest
LABEL maintainer="fuhaiq@gmail.com"

########################################下载相关依赖###############################
RUN yum install -y net-tools openssh-clients openssh-server ntp perl which psmisc cyrus-sasl-plain cyrus-sasl-gssapi gcc python-devel cyrus-sasl*


#######################################生成SSH初始秘钥###########################################
RUN /usr/bin/ssh-keygen -A

#######################################替换时区##################################################
RUN sh -c '/bin/echo -e "y" | cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime'

#######################################配置JAVA环境##############################################
ADD jdk-8u191-linux-x64.tar.gz /opt
ENV JAVA_HOME /opt/jdk1.8.0_191

#######################################添加CM，parcel安装包，并配置CM环境########################
ADD cloudera-manager-centos7-cm5.16.1_x86_64.tar.gz /opt
RUN useradd --system --home=/opt/cm-5.16.1/run/cloudera-scm-server --no-create-home --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm
RUN mkdir -p /opt/cloudera/parcel-repo/
COPY CDH-5.16.1-1.cdh5.16.1.p0.3-el7.parcel /opt/cloudera/parcel-repo/
COPY CDH-5.16.1-1.cdh5.16.1.p0.3-el7.parcel.sha /opt/cloudera/parcel-repo/
COPY manifest.json /opt/cloudera/parcel-repo/
RUN chown -R cloudera-scm:cloudera-scm /opt/cloudera/parcel-repo
RUN mkdir -p /opt/cloudera/parcels
RUN chown -R cloudera-scm:cloudera-scm /opt/cloudera/parcels
RUN mkdir -p /var/lib/cloudera-scm-server
RUN chown cloudera-scm:cloudera-scm /var/lib/cloudera-scm-server
RUN mkdir -p /usr/share/java
COPY mysql-connector-java.jar /usr/share/java
RUN rm -rf /opt/cm-5.16.1/etc/cloudera-scm-server/db.properties
ADD db.properties /opt/cm-5.16.1/etc/cloudera-scm-server
##### mariadb 最新版本补丁，如果使用mariadb 5.5不用此补丁
RUN rm -rf /opt/cm-5.16.1/share/cmf/schema/mysql/05003_cmf_schema.mysql.ddl
ADD 05003_cmf_schema.mysql.ddl /opt/cm-5.16.1/share/cmf/schema/mysql
##### 挂载日记及数据目录，方便在容器外面操作
VOLUME ["/hadoop", "/opt/cm-5.16.1/log/cloudera-scm-server"]

#######################################集成Kerberos##############################################
RUN yum install krb5-server krb5-libs krb5-auth-dialog krb5-workstation openldap-clients -y
RUN rm -rf /etc/krb5.conf
COPY kerberos/krb5.conf /etc
RUN rm -rf /var/kerberos/krb5kdc/kdc.conf
COPY kerberos/kdc.conf /var/kerberos/krb5kdc
RUN rm -rf /var/kerberos/krb5kdc/kadm5.acl
COPY kerberos/kadm5.acl /var/kerberos/krb5kdc
COPY kerberos/jce/US_export_policy.jar $JAVA_HOME/jre/lib/security
COPY kerberos/jce/local_policy.jar $JAVA_HOME/jre/lib/security
##创建对应database
RUN kdb5_util create -r TOPFINE.COM -s -P topfine.com
##创建管理员账号
RUN kadmin.local -q "addprinc -pw cloudera-scm cloudera-scm/admin"

######################################设置入口脚本###############################################
COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

######################################开启端口###################################################
EXPOSE 7180
