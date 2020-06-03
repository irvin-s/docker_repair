FROM centos:centos7

RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum -y install nginx; yum -y clean all
RUN yum -y install tar; yum -y clean all
RUN yum -y install gcc; yum -y clean all

RUN curl -LO http://download.redis.io/releases/redis-stable.tar.gz
RUN mkdir -p /opt/redis
RUN tar -C /opt/redis --strip-components=1 -z -x -v -f redis-stable.tar.gz
RUN cd /opt/redis && make && make install && rm -rf /opt/redis

RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install supervisor
