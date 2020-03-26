FROM centos:centos6

# required or man pages won't ever be put on disk (though packages will install)
# http://superuser.com/a/817649
RUN \
  sed -i '/excludedocs/d' /etc/rpm/macros.imgcreate && \
  sed -i '/nodocs/d' /etc/yum.conf
RUN yum install -y vim man man-pages tree

RUN yum update -y
RUN yum groupinstall -y "development tools"

# install Valgrind from source: http://c.learncodethehardway.org/book/ex4.html
# use a newer version than the site since latest kernel is 3.x and not 2.6
RUN \
  cd /root && \
  curl -O 'http://valgrind.org/downloads/valgrind-3.10.0.tar.bz2' && \
  tar -xjvf valgrind-3.10.0.tar.bz2 && \
  cd valgrind-3.10.0 && \
  ./configure && \
  make && \
  make install
