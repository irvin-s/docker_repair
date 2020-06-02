FROM centos:centos6
MAINTAINER Tetsuo Yamabe

RUN yum reinstall -y glibc-common
RUN yum install -y locales java-1.7.0-openjdk-devel tar

RUN echo 'LANG="en_US.UTF-8"' >> /etc/sysconfig/i18n
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Add Epel repository

RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 

# Add Remi repository

RUN rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

# Add RPM Forge repository

RUN rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
RUN rpm -Uvh http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm

# Misc packages

RUN yum groupinstall -y "Development Tools"
RUN yum --enablerepo=epel install -y rsyslog wget sudo
RUN yum --enablerepo=rpmforge-extras install -y git

# Fetch and build Spark package

WORKDIR /home/root
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.1.1.tgz
RUN tar zxvf spark-1.1.1.tgz
WORKDIR /home/root/spark-1.1.1
RUN sbt/sbt assembly

# Install SparkR

WORKDIR /home/root
RUN yum install -y R
RUN wget http://cran.r-project.org/src/contrib/rJava_0.9-6.tar.gz
RUN R CMD INSTALL rJava_0.9-6.tar.gz
RUN R CMD javareconf

RUN yum install -y openssl098e 
RUN wget http://download2.rstudio.org/rstudio-server-0.98.1091-x86_64.rpm
RUN yum install -y --nogpgcheck rstudio-server-0.98.1091-x86_64.rpm

RUN yum install -y curl-devel
ADD files/sparkInstall.R /tmp/sparkInstall.R
RUN R --vanilla --slave < /tmp/sparkInstall.R

RUN groupadd rstudio
RUN useradd -g rstudio rstudio
RUN echo rstudio | passwd --stdin rstudio

EXPOSE 8787
CMD /usr/lib/rstudio-server/bin/rserver --server-daemonize 0
