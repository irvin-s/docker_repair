FROM centos:latest

RUN yum update;

#VOLUME ["/sys/fs/cgroup:/sys/fs/cgroup"]

#mariadb 
RUN yum -y install mariadb mariadb-server;
RUN systemctl enable mariadb;
#RUN systemctl start mariadb;
#RUN mysqladmin -u root password root;



#redis
RUN yum -y install epel-release;
RUN yum -y install redis;
RUN systemctl enable redis;
#RUN systemctl start redis;

# compile env
RUN yum -y install gcc gcc-c++ make cmake libuuid-devel openssl-devel curl-devel unzip;
RUN yum -y install wget;

RUN yum -y install mariadb-devel apr-util-devel;

# mybe opened if you want use system shared lib 
#RUN yum -y install protobuf-lite-devel hiredis-devel mariadb-devel protobuf;

RUN yum clean all;


# make a path for mount source code
RUN mkdir -p /opt/tt_source_code 

#COPY ./src /opt/tt_source_code/
#COPY ./build.sh /opt/



#RUN protoc -I=/opt/src/pb --cpp_out=/opt/src/base/pb/protocol/ /opt/src/pb/*.proto
#RUN chmod +x /opt/build.sh

CMD ["/usr/sbin/init"]
#RUN bash /opt/build.sh
