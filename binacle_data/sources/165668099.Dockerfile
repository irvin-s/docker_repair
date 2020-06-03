FROM wscherphof/oracle-linux-7
MAINTAINER Wouter Scherphof <wouter.scherphof@gmail.com>

# Install prerequisites
RUN yum install -y make libaio bc net-tools vte3

# Install oracle
ADD Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm
RUN yum localinstall -y /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm
RUN rm -f /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm

ENV ORACLE_SID  XE
ENV ORACLE_HOME /u01/app/oracle/product/11.2.0/xe
ENV PATH        $ORACLE_HOME/bin:$PATH

# Configure the new database
ADD Disk1/response/xe.rsp /u01/app/oracle/product/11.2.0/xe/config/scripts/xe.rsp
ADD initXETemp.ora        /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora
ADD init.ora              /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora
RUN service oracle-xe configure responseFile=/u01/app/oracle/product/11.2.0/xe/config/scripts/xe.rsp

EXPOSE 1521 8080

ADD start /tmp/start
CMD /tmp/start


