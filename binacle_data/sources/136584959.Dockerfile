from	ubuntu:14.04

run	echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
run	apt-get -y update

run apt-get -y install  software-properties-common
run	apt-get -y install  python-software-properties &&\
	apt-get -y update

# oracle java
run add-apt-repository  ppa:webupd8team/java &&\
	apt-get -y update &&\
	echo debconf shared/accepted-oracle-license-v1-1 select true | \
    debconf-set-selections &&\
    echo debconf shared/accepted-oracle-license-v1-1 seen true | \
    debconf-set-selections &&\
    apt-get -y install  oracle-java7-installer

run apt-get -y install  supervisor nginx-light git wget curl

run apt-get -y install  python-django-tagging python-simplejson python-memcache \
						python-ldap python-cairo python-django python-twisted   \
						python-pysqlite2 python-support python-pip gunicorn

# fake fuse
run  apt-get install libfuse2 &&\
     cd /tmp ; apt-get download fuse &&\
     cd /tmp ; dpkg-deb -x fuse_* . &&\
     cd /tmp ; dpkg-deb -e fuse_* &&\
     cd /tmp ; rm fuse_*.deb &&\
     cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst &&\
     cd /tmp ; dpkg-deb -b . /fuse.deb &&\
     cd /tmp ; dpkg -i /fuse.deb

# Graphite
#run	pip install whisper
#run	pip install --install-option="--prefix=/var/lib/graphite" --install-option="--install-lib=/var/lib/graphite/lib" carbon
#run	pip install --install-option="--prefix=/var/lib/graphite" --install-option="--install-lib=/var/lib/graphite/webapp" graphite-web

run cd /usr/local/src && git clone https://github.com/graphite-project/graphite-web.git
run cd /usr/local/src && git clone https://github.com/graphite-project/carbon.git
run cd /usr/local/src && git clone https://github.com/graphite-project/whisper.git

run cd /usr/local/src/whisper && git checkout master && python setup.py install
run cd /usr/local/src/carbon && git checkout 0.9.x && python setup.py install
run cd /usr/local/src/graphite-web && git checkout 0.9.x && python check-dependencies.py; python setup.py install

# Elastic Search
run    cd ~ && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.4.deb
run    cd ~ && dpkg -i elasticsearch-1.3.4.deb && rm elasticsearch-1.3.4.deb

# grafana, kibana
run	mkdir -p /www/data
run cd /tmp && wget http://grafanarel.s3.amazonaws.com/grafana-1.8.1.tar.gz &&\
	tar xzvf grafana-1.8.1.tar.gz && rm grafana-1.8.1.tar.gz &&\
	mv /tmp/grafana-1.8.1 /www/data/grafana
run cd /tmp && wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz &&\
	tar xzvf kibana-3.1.1.tar.gz && rm kibana-3.1.1.tar.gz &&\
	mv /tmp/kibana-3.1.1 /www/data/kibana


######## no 'add' before this line to utilize caching (see http://crosbymichael.com/dockerfile-best-practices.html)


# Add graphite config
add	./graphite/initial_data.json /opt/graphite/webapp/graphite/initial_data.json
add	./graphite/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
add	./graphite/carbon.conf /opt/graphite/conf/carbon.conf
add	./graphite/storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
add	./graphite/storage-aggregation.conf /opt/graphite/conf/storage-aggregation.conf

run	mkdir -p /opt/graphite/storage/whisper
run	touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index
run	chown -R www-data /opt/graphite/storage
run	chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
run	chmod 0664 /opt/graphite/storage/graphite.db
run	cd /opt/graphite/webapp/graphite && python manage.py syncdb --noinput


# grafana, kibana config
add ./grafana/config.js /www/data/grafana/config.js
add ./kibana/config.js /www/data/kibana/config.js

# elasticsearch
add	./elasticsearch/run /usr/local/bin/run_elasticsearch

# Add system service config
add	./nginx/nginx.conf /etc/nginx/nginx.conf
add	./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# graphite render, es, kibana, grafana
expose	80
# graphite
expose  81

# Carbon line receiver port
expose	2003
# Carbon pickle receiver port
expose	2004
# Carbon cache query port
expose	7002

VOLUME ["/var/lib/elasticsearch"]
VOLUME ["/opt/graphite/storage/whisper"]
VOLUME ["/var/lib/log/supervisor"]

cmd	["/usr/bin/supervisord"]

# vim:ts=8:noet:
