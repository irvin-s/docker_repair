FROM centos:centos6
MAINTAINER Odd E. Ebbesen

ENV GR_C carbon
ENV GR_G graphite-web
ENV GR_TAG tags/0.9.13-pre1
ENV GR_BASEURL https://github.com/graphite-project
ENV GOSU_VERSION 1.11
ENV TINI_VERSION 0.18.0
ENV TINI_GPG_KEY 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7

WORKDIR /tmp/

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm \
		&& \
		yum install -y \
		bitmap-* \
		gcc \
		git \
		httpd \
		libffi-devel \
		mod_wsgi \
		openldap-devel \
		pycairo-devel \
		python-pip \
		&& \
		git clone ${GR_BASEURL}/${GR_C}.git \
		&& \
		git clone ${GR_BASEURL}/${GR_G}.git \
		&& \
		cd ${GR_C} \
		&& \
		git checkout ${GR_TAG} \
		&& \
		pip install -r requirements.txt \
		&& \
		python setup.py install \
		&& \
		cd - \
		&& \
		cd ${GR_G} \
		&& \
		git checkout ${GR_TAG} \
		&& \
		pip install -r requirements.txt \
		&& \
		python setup.py install \
		&& \
		cd - \
		&& \
		rm -rf ./${GR_C} ./${GR_G} \
		&& \
		yum clean all \
		&& \
		chown -R apache:apache /opt/graphite/storage

RUN curl -sL -o /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
	&& \
	chmod 755 /usr/local/bin/gosu
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static /sbin/tini
ADD https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static.asc /tmp/tini-static.asc
RUN gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys $TINI_GPG_KEY
RUN gpg --batch --verify /tmp/tini-static.asc /sbin/tini
RUN chmod 755 /sbin/tini

WORKDIR /opt/graphite

EXPOSE 80 2003 2004
VOLUME ["/opt/graphite/storage/whisper", "/opt/graphite/storage/log", "/opt/graphite/storage/rrd"]

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/sbin/tini", "-g", "--"]
