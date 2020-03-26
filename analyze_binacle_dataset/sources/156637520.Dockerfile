FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all && yum -y update && yum -y install net-tools bash-completion vim wget iptables openssl cronie && yum clean all

RUN mongo_v=$(curl -s https://www.mongodb.com/download-center |awk -F'Current Stable Release \\(' '{print $2}' |awk -F\) '{print $1}' |tr -s "\n" " "|sed 's/ //g') \
        && wget -c https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${mongo_v}.tgz \
        && wget -c https://raw.githubusercontent.com/mongodb/mongo/master/rpm/mongod.conf -O /etc/mongod.conf \
        && tar zxf mongodb-linux-x86_64-${mongo_v}.tgz \
        && \cp -a mongodb-linux-x86_64-${mongo_v}/bin/* /usr/local/bin/ \
        && rm -rf mongodb-linux-x86_64-*

RUN mkdir -p /var/log/mongodb && mkdir -p /var/lib/mongo && mkdir -p /var/run/mongodb

VOLUME /var/lib/mongo

COPY mongodb.sh /mongodb.sh
COPY backup.sh /backup.sh
RUN chmod +x /*.sh

ENTRYPOINT ["/mongodb.sh"]

EXPOSE 27017 28017

CMD ["mongod", "-f", "/etc/mongod.conf"]

# docker build -t mongodb .
# docker run -d --restart always -p 27017:27017 -p 28017:28017 -v /docker/mongodb:/var/lib/mongo -e MONGO_ROOT_PASS=newpass --hostname mongodb --name mongodb mongodb
# docker run -it --rm mongodb --help
