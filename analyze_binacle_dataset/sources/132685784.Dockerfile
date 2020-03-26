# docker-redis
#
# VERSION 0.2

FROM centos
MAINTAINER Dave Goehrig dave@dloh.org

# Install EPEL6 for additional packages
RUN yum -y install http://mirror.pnl.gov/epel/6/i386/epel-release-6-8.noarch.rpm

# Install Development Tools
RUN yum -y groupinstall "Development Tools"

# Download Redis source
RUN curl -O http://download.redis.io/releases/redis-2.6.16.tar.gz

# Untar redis source
RUN tar zxvf redis-2.6.16.tar.gz

# Build redis
RUN cd redis-2.6.16 && make

# Install redis
RUN cd redis-2.6.16 && make install

# Cleanup
RUN rm -rf redis-2.6.16.tar.gz redis-2.6.16

# expose port
EXPOSE 6379

# Run redis
CMD /usr/local/bin/redis-server
