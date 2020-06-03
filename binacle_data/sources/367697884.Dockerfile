FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Everton Gago <everton.gago@dextra-sw.com>

RUN apt-get update && apt-get install -y openssh-server && apt-get install rsync
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo "oracle-java7-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
RUN apt-get -y install oracle-java7-installer

RUN apt-get -y install vim
RUN wget -P /opt http://ftp.unicamp.br/pub/apache/hadoop/common/hadoop-2.6.2/hadoop-2.6.2.tar.gz
RUN wget -P /opt http://ftp.unicamp.br/pub/apache/mahout/0.11.0/apache-mahout-distribution-0.11.0.tar.gz

RUN tar xvfz /opt/hadoop-2.6.2.tar.gz -C /opt
RUN tar xvfz /opt/apache-mahout-distribution-0.11.0.tar.gz -C /opt
RUN rm /opt/hadoop-2.6.2.tar.gz
RUN rm /opt/apache-mahout-distribution-0.11.0.tar.gz

RUN echo "export JAVA_HOME=\"/usr/lib/jvm/java-7-oracle\"" >> /root/.bashrc
RUN echo "export HADOOP_PREFIX=\"/opt/hadoop-2.6.2\"" >> /root/.bashrc
RUN echo "export HADOOP_CONF_DIR=\"/opt/hadoop-2.6.2/etc/hadoop\"" >> /root/.bashrc
RUN echo "export PATH=\"/opt/hadoop-2.6.2/bin:$PATH\"" >> /root/.bashrc
RUN echo "export HADOOP_HOME=\"/opt/hadoop-2.6.2\""
RUN echo "export MAHOUT_HOME=\"/opt/apache-mahout-distribution-0.11.0\"" >> /root/.bashrc
RUN echo "export HADOOP_OPTS=\"-Xmx4096m\"" >> /root/.bashrc

ADD files /root/files
ADD run.sh /root/run.sh

RUN echo "export WORK_DIR=\"/root\"" >> /root/.bashrc

RUN mkdir /root/.ssh
RUN ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa
RUN cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
