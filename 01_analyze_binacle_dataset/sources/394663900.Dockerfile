FROM centos:centos6

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

# dependencies used to build Python 2.7
RUN yum install --enablerepo=centosplus -y tar bzip2 gcc make zlib-devel bzip2-devel readline-devel sqlite-devel openssl-devel

RUN	cd /tmp && \
	curl -O https://www.python.org/ftp/python/2.7.6/Python-2.7.6.tgz && \
	tar xzf Python-2.7.6.tgz && \
	cd /tmp/Python-2.7.6 && \
	./configure --prefix=/opt/python27 && make && make install
RUN	cd /tmp && \
	curl -O -L https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py && \
	/opt/python27/bin/python /tmp/get-pip.py && \
	/opt/python27/bin/pip install virtualenv supervisor

# cleanup
RUN rm -rf /tmp/* && yum clean metadata && yum clean all

