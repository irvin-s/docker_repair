FROM jaschac/debian-gcc
MAINTAINER Jascha Casadio <jascha@lostinmalloc.com>
ADD scripts/init_container.sh /usr/local/sbin/init_container.sh
ADD files/etc/cntlm.conf /etc/cntlm.conf
ADD files/cntlm-0.92.3/ /usr/local/src/cntlm-0.92.3/
EXPOSE 3128
CMD init_container.sh
