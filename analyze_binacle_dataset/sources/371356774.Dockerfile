FROM java:7

MAINTAINER "Yancey" <yancey1989@gmail.com>

RUN apt-get update && \
apt-get  install -y vim 

ENV hadoops /opt/hadoops


RUN mkdir /opt/home
RUN useradd -ms /bin/bash hadoop -d /opt/home/hadoop
RUN echo "hadoop:hadoop" | chpasswd  
RUN echo "hadoop ALL=(ALL)       ALL" >> /etc/sudoers 

RUN mkdir -p /opt/hadoops

RUN mkdir $hadoops/hdfs

RUN curl -s http://apache.fayea.com/hadoop/common/hadoop-2.6.4/hadoop-2.6.4.tar.gz | \
    tar zxf - -C /opt/ && \
    mv /opt/hadoop-2.6.4 ${hadoops}/hadoop/

ADD bashrc /root/.bashrc
