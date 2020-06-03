# Docker to create pgpool_setup ready environment.

FROM centos:centos6

MAINTAINER Tatsuo Ishii <ishii@sraoss.co.jp>

ENV PGHOME /var/lib/pgsql
ENV POSTGRESQL_VERSION 9.3
ENV POSTGRESQL_VERSION2 93
ENV RPM pgpool-II-pg93-3.3.4-2.pgdg.x86_64.rpm
ENV DEV_RPM pgpool-II-pg93-devel-3.3.4-2.pgdg.x86_64.rpm
ENV EXTENSION_RPM pgpool-II-pg93-extensions-3.3.4-2.pgdg.x86_64.rpm

RUN yum update -y

# Install PostgreSQL packages
RUN yum install -y wget
RUN wget http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
RUN rpm -ivh pgdg-centos93-9.3-1.noarch.rpm
RUN yum install -y postgresql${POSTGRESQL_VERSION2}-devel postgresql${POSTGRESQL_VERSION2} postgresql${POSTGRESQL_VERSION2}-server postgresql${POSTGRESQL_VERSION2}-contrib

# Install pgpool-II packages
RUN wget http://www.pgpool.net/download.php?f=${RPM} -O /tmp/${RPM}
RUN rpm -ivh /tmp/${RPM}
RUN wget http://www.pgpool.net/download.php?f=${DEV_RPM} -O /tmp/${DEV_RPM}
RUN rpm -ivh /tmp/${DEV_RPM}
RUN wget http://www.pgpool.net/download.php?f=${EXTENSION_RPM} -O /tmp/${EXTENSION_RPM}
RUN rpm -ivh /tmp/${EXTENSION_RPM}

# Install necessary buid tools and regression test tools
RUN yum install -y ed vi which openssh-server openssh-clients tar memcached-devel
RUN yum install -y rsync

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

# Add files
ADD pgpool_setup /usr/bin/pgpool_setup
ADD start.sh /tmp/start.sh
CMD /tmp/start.sh
