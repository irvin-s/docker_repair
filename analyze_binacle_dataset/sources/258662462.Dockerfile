#
# OpenJDK 7 Dockerfile
#
# Pull base image.
FROM ubuntu:14.04
MAINTAINER thushear <lucas421634258@gmail.com>

RUN echo "deb http://mirrors.163.com/ubuntu/ trusty main restricted universe multiverse" > /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-proposed main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.163.com/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list

WORKDIR /root
# Install Java.
RUN apt-get update && apt-get install -y openssh-server openjdk-7-jdk wget vim  zip


# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

COPY ssh_config /tmp/
RUN mv /tmp/ssh_config ~/.ssh/config 


ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH  /usr/lib/jvm/java-7-openjdk-amd64/bin:$PATH

RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config


EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
