# Docker to create pgpool_setup ready environment.

FROM centos:centos7

MAINTAINER Tadashi Inagaki <tadashi.1027@gmail.com>

ENV PGHOME /var/lib/pgsql
ENV POSTGRESQL_VERSION 9.4
ENV POSTGRESQL_VERSION2 94
ENV RPM pgpool-II-pg94-3.4.3-1pgdg.rhel7.x86_64.rpm
ENV DEV_RPM pgpool-II-pg94-devel-3.4.3-1pgdg.rhel7.x86_64.rpm
ENV EXTENSION_RPM pgpool-II-pg94-extensions-3.4.3-1pgdg.rhel7.x86_64.rpm

RUN yum update -y

# Install PostgreSQL packages
RUN yum install -y wget
RUN wget http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm
RUN rpm -ivh pgdg-centos94-9.4-1.noarch.rpm
RUN yum install -y postgresql${POSTGRESQL_VERSION2}-devel postgresql${POSTGRESQL_VERSION2} postgresql${POSTGRESQL_VERSION2}-server postgresql${POSTGRESQL_VERSION2}-contrib

# Install pgpool-II packages
RUN yum install -y libmemcached
RUN wget http://www.pgpool.net/yum/rpms/3.4/redhat/rhel-7-x86_64/${RPM} -O /tmp/${RPM}
RUN rpm -ivh /tmp/${RPM}
RUN wget http://www.pgpool.net/yum/rpms/3.4/redhat/rhel-7-x86_64/${DEV_RPM} -O /tmp/${DEV_RPM}
RUN rpm -ivh /tmp/${DEV_RPM}
RUN wget http://www.pgpool.net/yum/rpms/3.4/redhat/rhel-7-x86_64/${EXTENSION_RPM} -O /tmp/${EXTENSION_RPM}
RUN rpm -ivh /tmp/${EXTENSION_RPM}

# Install necessary packages for pgpool_setup
RUN yum install -y ed vi which openssh-server openssh-clients tar memcached-devel
RUN yum install -y rsync

# Install necessary packages for pgpoolAdmin
RUN yum install -y httpd php php-pgsql

# Install pgpoolAdmin
ENV PGPOOLADMIN pgpoolAdmin-3.4.0-1.pgdg.noarch.rpm
RUN wget http://www.pgpool.net/download.php?f=${PGPOOLADMIN} -O /tmp/${PGPOOLADMIN}
RUN rpm -ivh /tmp/${PGPOOLADMIN}

# Setup postgres account
ENV BASHPROFILE .bash_profile
RUN echo "PATH=/usr/pgsql-${POSTGRESQL_VERSION}/bin:$PATH" >> $PGHOME/$BASHPROFILE
RUN echo "PATH=$PATH:/usr/pgsql-${POSTGRESQL_VERSION}/bin" >> /root/$BASHPROFILE
RUN echo "export PGBIN=/usr/${POSTGRESQL_VERSION}/bin" >> $PGHOME/$BASHPROFILE

# Setup SSH to allow password less login to itself
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN su -c 'ssh-keygen -N "" -t rsa -f $PGHOME/.ssh/id_rsa;cp $PGHOME/.ssh/id_rsa.pub $PGHOME/.ssh/authorized_keys' postgres
RUN su -c 'echo "StrictHostKeyChecking no" > $PGHOME/.ssh/config' postgres
RUN echo "postgres:postgres" | chpasswd

# Just in case set root password
RUN echo "root:root" | chpasswd

# Run apache2 as "postgres" user for pgpoolAdmin
RUN sed -ri 's/User apache/User postgres/' /etc/httpd/conf/httpd.conf
RUN sed -ri 's/Group apache/Group postgres/' /etc/httpd/conf/httpd.conf

# Add files
ADD pgpool_setup /usr/bin/pgpool_setup
ADD pgmgt.conf.php /var/www/html/pgpoolAdmin/conf/pgmgt.conf.php
ADD start.sh /tmp/start.sh
ADD pgpool_setup.sh /tmp/pgpool_setup.sh
CMD /tmp/start.sh
