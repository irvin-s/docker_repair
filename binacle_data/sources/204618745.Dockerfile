FROM centos:7.1.1503

RUN yum install -y wget epel-release \
    && yum swap -y fakesystemd systemd \
    && wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo \
    && echo -e '[WANdiscoSVN]\n\
name=WANdisco SVN Repo 1.9\n\
enabled=1\n\
baseurl=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/$basearch/\n\
gpgcheck=1\n\
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco\n' >> /etc/yum.repos.d/wandisco-svn.repo \
    && yum groupinstall "Development Tools" -y \
    && yum install -y apache-maven python-devel python-boto java-1.8.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel ruby-devel \
    && gem install fpm --no-ri --no-rdoc

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk