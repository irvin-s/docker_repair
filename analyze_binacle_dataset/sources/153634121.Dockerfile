#Required environment variables
#eums.environment => name corresponding with the different settings files e.g. qa, snap, staging, test

#  Base OS
FROM ubuntu:14.04
MAINTAINER eums <eums@thoughtworks.com>

##############################################################################
## Change policy
##############################################################################
RUN echo exit 0 > /usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d

RUN export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget curl build-essential libpq-dev

##############################################################################
## Python 2.7.9 Pre-requisites
##############################################################################
# remove several traces of debian python
RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8
ENV LANGUAGE en_US

#The properties below are not used as parameters to facilitate docker caching and faster builds
#They have been left here more as doc so be sure to update them if you change the version
ENV PYTHON_VERSION 2.7.9

# gpg: key 18ADD4FF: public key "Benjamin Peterson <benjamin@python.org>" imported
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF

RUN set -x \
	&& mkdir -p /usr/src/python \
	&& curl -SLO "https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz" \
	&& curl -SLO "https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz.asc"
RUN	gpg --verify Python-2.7.9.tar.xz.asc \
	&& tar -xJC /usr/src/python --strip-components=1 -f Python-2.7.9.tar.xz \
	&& rm Python-2.7.9.tar.xz* \
	&& cd /usr/src/python \
	&& ./configure --enable-shared --enable-unicode=ucs4 \
	&& make -j$(nproc) \
	&& make install \
	&& ldconfig
RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
	&& find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& rm -rf /usr/src/python

RUN pip install virtualenv

RUN apt-get update && apt-get install -y supervisor openssh-server postgresql postgresql-contrib nodejs nginx redis-server git
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

RUN echo "root:password" | chpasswd  # need a password for ssh
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

##############################################################################
## install NodeJS
##############################################################################
# verify gpg and sha256: http://nodejs.org/dist/v0.10.30/SHASUMS256.txt.asc
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

RUN curl -SLO "http://nodejs.org/dist/v0.10.21/node-v0.10.21-linux-x64.tar.gz"
RUN curl -SLO "http://nodejs.org/dist/v0.10.21/SHASUMS256.txt.asc"
RUN gpg --verify SHASUMS256.txt.asc
RUN grep " node-v0.10.21-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c -
RUN tar -xzf "node-v0.10.21-linux-x64.tar.gz" -C /usr/local --strip-components=1
RUN curl -SLO "http://nodejs.org/dist/v0.10.21/SHASUMS256.txt.asc"
RUN rm "node-v0.10.21-linux-x64.tar.gz" SHASUMS256.txt.asc
RUN npm install -g npm@1.4.28
RUN npm install -g npm@"1.3.11"
RUN npm install -g grunt-cli@0.1.13
RUN npm cache clear


##############################################################################
## install MongoDB
##############################################################################
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN sudo apt-get update
RUN apt-get install -y mongodb-org=2.6.5 mongodb-org-server=2.6.5 mongodb-org-shell=2.6.5 mongodb-org-mongos=2.6.5 mongodb-org-tools=2.6.5
ENV LC_ALL C

##############################################################################
## install Elasticsearch
##############################################################################
# Install Java
RUN sudo rm -fr /var/lib/apt/lists
RUN sudo apt-get update
RUN sudo apt-get install -y software-properties-common
RUN sudo apt-add-repository ppa:webupd8team/java
RUN sudo apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

RUN sudo apt-get install -y oracle-java8-installer

# Add elasticsearch repository to apt-get repositories
RUN mkdir -p /opt/downloads
RUN cd /opt/downloads && curl -SsfLO "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.3.deb"

# Install Elasticsearch
RUN dpkg -i /opt/downloads/elasticsearch-1.7.3.deb

# Enable Cross-site Origin Requests to Elasticsearch
RUN sudo echo 'http.cors.enabled : true' >> /etc/elasticsearch/elasticsearch.yml

# Set MAX_MAP_COUNT configuration off. When on, an error is returned because docker is a readonly OS
RUN sed -i '/sysctl -q -w vm.max_map_count/ s/^#*/true\n#/' /etc/init.d/elasticsearch

# Set elasticsearch to run with root user
RUN sed -i '/^ES_USER=el/ s/^#*/true\nES_USER=root\n#/' /etc/init.d/elasticsearch
RUN sed -i '/^ES_GROUP=el/ s/^#*/true\nES_GROUP=root\n#/' /etc/init.d/elasticsearch

# Enable Elasticsearch service to start on boot
RUN sudo update-rc.d elasticsearch defaults 95 10

##############################################################################
# Install UWSGI and config
##############################################################################
RUN apt-get install -y python-dev
RUN pip install uwsgi
COPY ./eums/scripts/packaging/eums.uwsgi.ini /etc/uwsgi/sites/eums.uwsgi.ini

COPY ./eums/scripts/packaging/nginx.config /etc/nginx/nginx.conf
COPY ./eums/scripts/packaging/eums.nginx.config /etc/nginx/sites-available/eums
RUN ln -sf /etc/nginx/sites-available/eums /etc/nginx/sites-enabled/eums
RUN rm /etc/nginx/sites-enabled/default
##############################################################################
## Install dependenices
##############################################################################
COPY ./eums/requirements.txt /opt/app/eums/requirements.txt
RUN virtualenv ~/.virtualenvs/eums
RUN /bin/bash -c "source ~/.virtualenvs/eums/bin/activate && cd /opt/app/eums && pip install -r requirements.txt"

COPY ./contacts/package.json /opt/app/contacts/package.json
RUN cd /opt/app/contacts/ && npm install fibers@1.0.15 && npm install

COPY ./eums/eums/client/package.json /opt/app/eums/eums/client/package.json
RUN cd /opt/app/eums/eums/client && npm install

#RUN cd /opt/app/eums/eums/client && npm install -g bower
#COPY ./eums/eums/client/bower.json /opt/app/eums/eums/client/bower.json
#RUN cd /opt/app/eums/eums/client && bower install --allow-root
ADD ./eums/eums/client/bower_components /opt/app/eums/eums/client/bower_components/


RUN cd /opt/app/eums/eums/client && npm install -g grunt-cli

##############################################################################
## Add the codebase to the image
##############################################################################
COPY ./eums /opt/app/eums
COPY ./contacts /opt/app/contacts
COPY ./contacts/scripts/startContacts.sh /opt/scripts/startContacts.sh
COPY ./eums/scripts/deployment/startPostgres.sh /opt/scripts/startPostgres.sh
COPY ./eums/scripts/deployment/buildConfigs.sh /opt/scripts/buildConfigs.sh
COPY ./eums/scripts/deployment/celery.sh /opt/scripts/celery.sh
COPY ./eums/scripts/deployment/startProcessListener.sh /opt/scripts/startProcessListener.sh
COPY ./eums/scripts/setupmap /opt/scripts/setupmap
RUN chmod a+x -R /opt/scripts
RUN chmod a+x -R /opt/app/eums/scripts

COPY ./eums/scripts/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./eums/scripts/supervisor/celeryd.conf /etc/supervisor/conf.d/celeryd.conf
RUN mkdir /var/log/celery
RUN touch /var/log/celery/workers.log

VOLUME /var/lib/postgresql
VOLUME /data

EXPOSE 22 80

##############################################################################
## Entrypoint and command parameters
##############################################################################
CMD ["/usr/bin/supervisord"]
