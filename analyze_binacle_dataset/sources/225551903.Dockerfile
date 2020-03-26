FROM python:3.6
MAINTAINER letsmeet.click Contributors

RUN apt-get update && apt-get install -y \
	bash \
	binutils \
	curl \
	g++ \
	gdal-bin \
	git \
	lib32z1-dev \
	libfreetype6-dev \
	libjpeg-dev \
	libmemcached-dev \
	libproj-dev \
	libxml2-dev \
	libxslt1-dev \
	locales \
	postgresql-client \
	postgresql-server-dev-all \
	sudo \
	zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd uid1000 -d /home/uid1000
RUN mkdir -p /home/uid1000 && chown uid1000: /home/uid1000

COPY requirements.txt /opt/code/requirements.txt
WORKDIR /opt/code
RUN pip3 install -Ur requirements.txt
COPY . /opt/code

RUN chown -R uid1000: /opt

WORKDIR /opt/code/letsmeet

USER uid1000

VOLUME /home/uid1000
EXPOSE 8011

# production stuff
ENTRYPOINT ["./start.sh"]
CMD ["web"]
