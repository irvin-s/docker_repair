FROM        centos:7

MAINTAINER  xjin@dataman-inc.com

COPY        onecmdb-2.1.0-linux.i386.tar.gz /root/

RUN         yum install -y glibc.i686

RUN         cd /root && tar -xvf onecmdb-2.1.0-linux.i386.tar.gz && rm *.tar.gz

COPY        run.sh /root/onecmdb/

RUN         chmod a+x /root/onecmdb/run.sh

WORKDIR     /root/onecmdb

EXPOSE      8080

CMD         ./run.sh
