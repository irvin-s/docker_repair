# The `docker-harbor` infrastructure is crafted to get started on a project  
# quickly. This base image can be used early in development and parts can be  
# added or removed later as necessary (or the base image changed entirely).  
#  
# - Ubuntu 12.04 base image  
# - Python 2.7 with  
# - Flask  
# - SqlAlchemy  
# - etc.  
# - Redis (from source)  
# - Postgres  
# - Supervisor  
# - vim  
#  
# Some taken from:  
# - https://github.com/pitrho/docker-precise-redis/blob/master/Dockerfile  
FROM ubuntu:12.04  
MAINTAINER Brandon Thomas "bt@brand.io"  
#  
# Basic tools  
# - build tools  
# - editor  
# - unix needs  
#  
RUN apt-get update  
RUN apt-get install -y \  
wget \  
gcc \  
make \  
g++ \  
build-essential \  
libc6-dev \  
tcl \  
postgresql \  
postgresql-server-dev-9.1 \  
python-dev \  
python-setuptools \  
git-core \  
vim  
  
#  
# Redis Compile  
# - Redis isn't in the Ubuntu 12.04 repos, so build it.  
#  
ENV REDIS_RELEASE 2.8.3  
ENV REDIS_DIR /var/lib/redis  
ENV REDIS_LOG_DIR /var/log/redis  
ENV REDIS_DATA_DIR /var/lib/redis  
ENV REDIS_PID_DIR /var/run/redis  
  
RUN wget http://download.redis.io/releases/redis-$REDIS_RELEASE.tar.gz  
RUN tar -zxf redis-$REDIS_RELEASE.tar.gz  
RUN cd redis-$REDIS_RELEASE && /usr/bin/make install  
  
RUN mkdir -p $REDIS_DIR  
RUN mkdir -p $REDIS_LOG_DIR  
RUN mkdir -p $REDIS_DATA_DIR  
RUN mkdir -p $REDIS_PID_DIR  
  
RUN useradd redis  
  
RUN chown redis:redis $REDIS_DIR  
RUN chown redis:redis $REDIS_LOG_DIR  
RUN chown redis:redis $REDIS_DATA_DIR  
RUN chown redis:redis $REDIS_PID_DIR  
  
#  
# Python Tooling  
#  
RUN easy_install -U pip setuptools  
  
#  
# Supervisor and Python Packages  
#  
RUN pip install \  
supervisor \  
flask \  
sqlalchemy \  
requests \  
psycopg2  
  
#  
# Add configuration files, scripts, etc.  
#  
ADD config/redis.conf /etc/redis/redis.conf  
ADD config/start_redis.sh /  
  
RUN chmod a+x start_redis.sh  
  

