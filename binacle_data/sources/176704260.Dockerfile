FROM tomcat:7.0.59-jre7

MAINTAINER Mosen <mosen@users.noreply.github.com>

RUN rm -rf /usr/local/tomcat/webapps/*
ADD ROOT.war /usr/local/tomcat/webapps/ROOT.war
WORKDIR /usr/local/tomcat/webapps
RUN /usr/bin/unzip /usr/local/tomcat/webapps/ROOT.war -d /usr/local/tomcat/webapps/ROOT
RUN rm /usr/local/tomcat/webapps/ROOT.war

RUN rm /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/US_export_policy.jar
RUN rm /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/local_policy.jar
ADD US_export_policy.jar /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/US_export_policy.jar
ADD local_policy.jar /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/local_policy.jar
RUN mkdir -p /Library/JSS/Logs

# confd stuff
RUN mkdir -p /etc/confd/{conf.d,templates}
ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates
ADD confd /usr/bin/confd
RUN chmod +x /usr/bin/confd

# add etcdctl so that etcd is always aware of the number of jss' running.
ENV ETCD_VERSION 3.0.4

RUN curl -LOks https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    tar zxvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
    cp etcd-v${ETCD_VERSION}-linux-amd64/etcdctl /etcdctl && \
    rm -rf etcd-v* && \
    chmod +x /etcdctl
    

ADD jss.sh /usr/bin/jss.sh
RUN chmod +x /usr/bin/jss.sh

EXPOSE 8443

CMD ["jss.sh"]