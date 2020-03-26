FROM	phusion/baseimage

# Set correct environment variables.
ENV HOME /root

# WORKAROUND for docker build errors
RUN ln -s -f /bin/true /usr/bin/chfn

# Install MariaDB
RUN	apt-get -y update
RUN apt-get install -y software-properties-common
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror.netcologne.de/mariadb/repo/10.0/ubuntu trusty main'
RUN apt-get -y update
RUN	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y iproute mariadb-galera-server-10.0 galera-3 rsync netcat-openbsd socat pv

# this is for testing - can be commented out later
RUN	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y iputils-ping net-tools

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
RUN	add-apt-repository 'deb http://repo.percona.com/apt trusty main'
RUN	apt-get -y update
RUN	LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y percona-xtrabackup

# Add config(s) - standalone and cluster mode
ADD	./my-cluster.cnf /etc/mysql/my-cluster.cnf
ADD ./my-init.cnf /etc/mysql/my-init.cnf

expose	3306 4567 4444 22

ADD	./mariadb-setrootpassword.sh /usr/bin/mariadb-setrootpassword

RUN mkdir /etc/service/_ipv6
ADD ipv6.sh /etc/service/_ipv6/run

RUN mkdir /etc/service/_ssh
ADD ssh.sh /etc/service/_ssh/run

RUN mkdir /etc/service/mariadb
ADD mariadb-start.sh /etc/service/mariadb/run

# Use phusion baseimage-docker's init system.
CMD ["/sbin/my_init"]
