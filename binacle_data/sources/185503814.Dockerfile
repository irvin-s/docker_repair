FROM centos

RUN yum update -y
RUN yum install -y gcc make tar wget

ADD setup_mssql.sh /tmp/setup_mssql.sh
RUN /tmp/setup_mssql.sh


