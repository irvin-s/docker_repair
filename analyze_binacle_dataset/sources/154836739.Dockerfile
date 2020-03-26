FROM centos:6.6

RUN yum install -y unzip krb5-workstation

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm"
RUN rpm -ivh jdk-7u79-linux-x64.rpm
ENV JAVA_HOME /usr/java/default
RUN java -version

RUN curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip"
RUN unzip UnlimitedJCEPolicyJDK7.zip
RUN cp UnlimitedJCEPolicy/US_export_policy.jar /usr/java/default/jre/lib/security/US_export_policy.jar
RUN cp UnlimitedJCEPolicy/local_policy.jar /usr/java/default/jre/lib/security/local_policy.jar

ADD zeppelin-build.tar.gz /tmp/
RUN ls -l /tmp/zeppelin-build
RUN mv /tmp/zeppelin-build /usr/lib/zeppelin

ENTRYPOINT ["/usr/lib/zeppelin/bin/zeppelin.sh","--config","/usr/lib/zeppelin/conf"]
