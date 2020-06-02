#Kippo
#start with ubuntu
FROM ubuntu:latest

MAINTAINER Spenser Reinhardt
ENV DEBIAN_FRONTEND noninteractive
ENV logfile /var/log/install.log

#apt-get sources
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse'     /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list

# updates and prereqs
RUN apt-get update -y && \
apt-get install git wget python-dev openssl python-openssl python-pyasn1 python-twisted -y

#user
RUN useradd -d /opt/kippo -s /sbin/nologin -M kippo -U

#install kippo
WORKDIR /opt/
RUN git clone https://github.com/desaster/kippo.git kippo && \
chown -R kippo:kippo kippo/ && \
cd kippo/ && \
rm kippo.cfg.dist && \
sed -i 's/kippo.pid/kippo.pid -n/g' /opt/kippo/start.sh

#cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD kippo.cfg /opt/kippo/kippo.cfg
EXPOSE 2222
USER kippo
WORKDIR /opt/kippo/
VOLUME /opt/kippo/log/
CMD ["./start.sh"]
