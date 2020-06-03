# Dockerfile for running shinken test scripts
# DO NOT BUILD IT BY YOURSELF, USE 
#`ryba prepare -m '@rybajs/metal/shinken/poller/*'`
FROM centos:latest

### PACKAGES ###
# add epel repo
RUN yum -y install wget
RUN wget -r -l1 --no-parent -A 'epel-release*.rpm' 'http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/'
RUN rpm -iUvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release*.noarch.rpm
RUN rm -rf dl.fedoraproject.org

RUN yum clean all && yum swap fakesystemd systemd
RUN yum -y update
# Install additionnal tools
RUN yum -y install sudo krb5-workstation libev libev-devel nmap-ncat jwhois cronie
# Install dev tools
RUN yum -y install git gcc gcc-c++ make snappy-devel openssl-devel expat-devel cyrus-sasl-devel mysql-devel
# Install php
RUN yum -y install php
# Install PERL
RUN yum -y install perl perl-devel perl-CPAN perl-libwww-perl perl-DBD-MySQL
# Install python
RUN yum -y install python-setuptools python-pip python-devel
# Disable require tty for sudo
RUN sed -i 's/Defaults.*requiretty/# Defaults requiretty/g' /etc/sudoers
# Install CPANM
#RUN curl -L http://cpanmin.us | perl - --sudo App::cpanminus
# Install HDP repo
# RUN wget {{ executor.hdp_repo }} -O /etc/yum.repos.d/hdp.repo --no-check-certificate 
# RUN sed -i 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.repos.d/hdp.repo
# RUN yum -y update
# RUN yum -y install hive
# Install JAVA
# COPY {{ executor.java.jdk.location }} /tmp/ryba-java/java.tar.gz
# RUN tar xzf /tmp/ryba-java/java.tar.gz -C /tmp/ryba-java
# RUN rm /tmp/ryba-java/java.tar.gz
# RUN mkdir /usr/java
# RUN mv /tmp/ryba-java/jdk{{ executor.java.jdk.version }} /usr/java/{{ executor.java.jdk.version }}
# RUN ln -sf /usr/java/{{ executor.java.jdk.version }} /usr/java/latest
# RUN ln -sf /usr/java/{{ executor.java.jdk.version }} /usr/java/default
# COPY java.sh /etc/profile.d/java.sh
# Install JAVA Policy
# COPY jce_policy-7/local_policy.jar /usr/java/default/jre/lib/security/local_policy.jar
# COPY jce_policy-7/US_export_policy.jar /usr/java/default/jre/lib/security/US_export_policy.jar
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod -R 600 /root/.ssh
### LAYOUT ###
RUN useradd -ms /bin/bash {{ user.name }}
RUN echo "{{ user.name }}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER {{ user.name }}
WORKDIR /home/{{ user.name }}
RUN wget https://labs.consol.de/assets/downloads/nagios/check_mysql_health-2.2.2.tar.gz -O check_mysql.tar.gz
RUN tar xzvf check_mysql.tar.gz
RUN rm check_mysql.tar.gz
WORKDIR check_mysql_health-2.2.2
RUN ./configure --prefix=/home/{{ user.name }}
RUN make
RUN make install
RUN rm -rf check_mysql_health-2.2.2
WORKDIR /home/{{ user.name }}
# Downloading shinken-plugins
RUN git clone 'https://github.com/ryba-io/hadoop-monitoring-plugins' plugins
RUN sudo pip install -r plugins/py_requirements.txt
RUN rm -rf plugins/.git*
RUN mkdir -p plugins/mysql
RUN mv libexec/check_mysql_health plugins/mysql/check_health
RUN rm -rf check_mysql_health*
RUN rm -r libexec
WORKDIR /home/{{ user.name }}/plugins
CMD sudo crond -n
