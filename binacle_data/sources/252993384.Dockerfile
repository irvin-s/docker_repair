from ubuntu:14.04
ENV GRAPHITE_RELEASE 0.9.15

RUN apt-get update && apt-get -y install git supervisor libcairo2-dev libffi-dev pkg-config python-dev python-pip fontconfig apache2 libapache2-mod-wsgi git-core collectd memcached gcc g++ make libtool automake libfontconfig1 libfreetype6 wget

# Download source repositories for Graphite/Carbon/Whisper and Statsite
RUN cd /usr/local/src ;\
	git clone https://github.com/graphite-project/graphite-web.git ;\
	git clone https://github.com/graphite-project/carbon.git ;\
	git clone https://github.com/graphite-project/whisper.git ;\
	git clone https://github.com/armon/statsite.git

# Build and install Graphite/Carbon/Whisper and Statsite
RUN cd /usr/local/src/whisper; git checkout ${GRAPHITE_RELEASE}; python setup.py install ;\
	cd ../carbon; git checkout ${GRAPHITE_RELEASE}; pip install -r requirements.txt; python setup.py install ;\
	cd ../graphite-web; git checkout ${GRAPHITE_RELEASE}; pip install -r requirements.txt; python check-dependencies.py; python setup.py install ;\
	cd ../statsite; ./bootstrap.sh; ./configure; make; cp src/statsite /usr/local/sbin/; cp sinks/graphite.py /usr/local/sbin/statsite-sink-graphite.py

# Install configuration files for Graphite/Carbon and Apache
COPY templates/statsite/statsite.conf /etc/statsite.conf
RUN mkdir /opt/graphite/conf/examples ; mv /opt/graphite/conf/*.example /opt/graphite/conf/examples/
COPY templates/graphite/conf/* /opt/graphite/conf/
COPY templates/apache/graphite.conf /etc/apache2/sites-available/

# Setup the correct Apache site and modules
RUN a2dissite 000-default ;\
	a2ensite graphite ;\
	a2enmod ssl ;\
	a2enmod socache_shmcb ;\
	a2enmod rewrite ;\
	mkdir -p /opt/graphite/storage/log/apache2/ ;\
	chown -R www-data:www-data /opt/graphite/storage/log

# Install configuration files for Django
COPY templates/graphite/webapp/* /opt/graphite/webapp/graphite/
RUN cd /opt/graphite/webapp/graphite/ ;\
	sed -i -e "s/UNSAFE_DEFAULT/`date | md5sum | cut -d ' ' -f 1`/" local_settings.py


# Setup the Django database
RUN cd /opt/graphite/webapp/graphite/ ; ls -al ;\
	python manage.py syncdb --noinput ;\
	chown www-data:www-data /opt/graphite/storage/graphite.db

# Add carbon system user and set permissions
RUN groupadd -g 998 carbon ;\
	useradd -c "carbon user" -g 998 -u 998 -s /bin/false carbon ;\
	chmod 775 /opt/graphite/storage/ ;\
	chown www-data:carbon /opt/graphite/storage/ ;\
	chown -R carbon /opt/graphite/storage/whisper

# Install grafana
RUN wget -O /tmp/grafana.deb https://grafanarel.s3.amazonaws.com/builds/grafana_latest_amd64.deb ;\
	cd /tmp && dpkg -i grafana.deb && rm grafana.deb

# cleanup
RUN rm -rf /usr/local/src/*
RUN apt-get -y purge gcc g++ make libtool automake libcairo2-dev libffi-dev pkg-config python-dev
RUN apt-get autoremove -y

COPY templates/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/opt/graphite/storage"]
EXPOSE 2003
EXPOSE 443
EXPOSE 8125
EXPOSE 3000

CMD ["/usr/bin/supervisord"]

