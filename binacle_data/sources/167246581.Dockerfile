# glastopf
# start with ubuntu
FROM ubuntu:latest

MAINTAINER Spenser Reinhardt
ENV DEBIAN_FRONTEND noninteractive

# sources
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse'     /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list

# updates and prereqs
RUN apt-get update -y && \
apt-get install git-core lsb-release python2.7 python-openssl python-gevent libevent-dev python2.7-dev build-essential make \
python-chardet python-requests python-sqlalchemy python-lxml python-beautifulsoup mongodb python-pip \ 
python-dev python-setuptools g++ git php5 php5-dev liblapack-dev gfortran libmysqlclient-dev libxml2-dev \
libxslt-dev -y && \
pip install --upgrade distribute

WORKDIR /opt/

# checout and build latest php sandbox
RUN git clone git://github.com/glastopf/BFR.git && \
cd BFR/ && \
phpize && \
./configure --enable-bfr && \
make && \
make install && \
for i in $(find / -type f -name php.ini); do \
	sed -i "/[PHP]/azend_extension=$(find /usr/lib/php5 -type f -name bfr.so)" $i; \
done    

# Clone and build glastopf
RUN git clone https://github.com/glastopf/glastopf.git glastopf && \
cd glastopf/ && \
python setup.py install
       
# Make dir for glastopf env
RUN mkdir myhoneypot
WORKDIR myhoneypot/

# Initialize config - might be causing build timeout
#RUN glastopf-runner 2>&1 | tee -a "${logfile}"

# Finished
# Clean up when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ./install.sh

EXPOSE 80 443
VOLUME /opt/myhoneynet/log
WORKDIR /opt/myhoneypot
CMD ["glastopf-runner"]
