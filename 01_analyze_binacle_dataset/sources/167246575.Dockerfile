#conpot
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

#dependencies
RUN apt-get update && \
apt-get install git-core python python-dev libmysqlclient-dev libxslt1-dev libsmi2ldbl snmp-mibs-downloader -y && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Build here
RUN cd /opt/ && \
git clone https://github.com/glastopf/conpot.git && \
cd conpot/ && \
python setup.py install

#Add config
ADD conpot.cfg /opt/conpot/conpot.cfg

EXPOSE 80 102 161 503
WORKDIR /opt/conpot
VOLUME /opt/conpot/var/
ENTRYPOINT ["/usr/bin/python"]
CMD ["/opt/conpot/bin/conpot", "-c", "/opt/conpot/conpot.cfg", "-t", "/opt/conpot/conpot/templates/default/", "-l", "/opt/conpot/var/conpot.log"]
