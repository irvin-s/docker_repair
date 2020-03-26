# Thug web browser honeypot
#start with ubuntu
FROM ubuntu:latest

MAINTAINER Spenser Reinhardt
ENV DEBIAN_FRONTEND noninteractive
ENV V8_HOME /tmp/v8
WORKDIR /tmp/

#apt-get sources
RUN sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse'     /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list && \
sed -i '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list

# updates and prereqs
RUN apt-get update -y && \
apt-get install -y python2.7 python2.7-dev python-pip python-beautifulsoup python-html5lib \
libemu2 libemu-dev python-libemu python-pefile python-lxml python-chardet python-httplib2 \
python-requests libboost-all-dev libboost-python-dev python-cssutils zope* python-pygraphviz \
python-pyparsing python-pydot python-magic python-yara libyara2 mongodb python-pymongo \
python-librabbitmq python-pika python-setuptools libxml2-dev libxslt-dev graphviz mongodb \
build-essential autoconf libtool subversion wget git-core bison libc6

#google-v8
RUN svn checkout http://v8.googlecode.com/svn/trunk/ && \
svn checkout http://pyv8.googlecode.com/svn/trunk/ pyv8 && \
wget https://raw.githubusercontent.com/buffer/thug/master/patches/PyV8-patch1.diff && \
patch -p0 < PyV8-patch1.diff && \
cd pyv8/ && \
python setup.py build && \
python setup.py install

#python deps
RUN pip install jsbeautifier rarfile html5lib beautifulsoup4 \
pefile lxml chardet httplib2 requests cssutils \
zope.interface pyparsing pydot2 python-magic pymongo

#Install Libemu & apply ld fix
RUN git clone git://git.carnivore.it/libemu.git && \
cd libemu/ && \
autoreconf -v -i && \
./configure --prefix=/opt/libemu && \
for file in $(find ./ -name Makefile); do sed -i 's/-Werror//g' $file; done && \
make install && \
touch /etc/ld.so.conf.d/libemu.conf && \
echo "/opt/libemu/lib/" > /etc/ld.so.conf.d/libemu.conf && \
ldconfig

#Install Pylibemu
RUN git clone git://github.com/buffer/pylibemu.git && \
cd pylibemu/ && \
python setup.py build && \
python setup.py install

WORKDIR /opt/

#Install Yara & yara-python
RUN git clone https://github.com/plusvic/yara.git && \
cd yara/ && \
bash build.sh && \
make install && \
cd yara-python/ && \
python setup.py build && \
python setup.py install

#thug
RUN git clone https://github.com/buffer/thug.git thug && \
python /opt/thug/src/thug.py -h && \
mkdir -p thug/var/log thug/var/out thug/var/in

#cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /opt/thug/var/log
WORKDIR /opt/thug/
ENTRYPOINT ["/bin/bash"]
CMD ["-c", \
"/usr/bin/python", \
"src/thug.py", \
"--useragent=winxpchrome20", \
"--delay=180", \
"--threshold=200", \
"--timeout=300", \
"--vtquery", \
"--vtsubmit", \
"--no-cache", \
"--logdir=var/log/", \
"--output=var/out/", \
"--verbose"]
