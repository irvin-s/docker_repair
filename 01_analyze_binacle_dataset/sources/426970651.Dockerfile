FROM debian:jessie
MAINTAINER Kostas Papadimitriou "kpap@grnet.gr"

RUN find /var/lib/apt -type f -exec rm {} \+
RUN apt-get -y update
RUN apt-get -y install vim git lsb-release wget multitail
RUN wget https://apt.puppetlabs.com/puppetlabs-release-pc1-jessie.deb
RUN apt-get -y install puppet puppet-module-puppetlabs-apt puppet-module-puppetlabs-stdlib

RUN puppet module install puppetlabs-apache --version 1.11.0
RUN puppet module install puppetlabs-postgresql --version 4.9.0
RUN puppet module install "stankevich/python" --version 1.18.2

ADD deploy/packages.pp /srv/deploy/packages.pp
RUN cd /srv/deploy && puppet apply -v packages.pp

ADD deploy/hiera.yaml /etc/puppet/hiera.yaml
RUN mkdir /srv/zeus_app


ADD . /srv/zeus_app
ADD deploy/config.yaml /etc/puppet/hieraconf/common.yaml

COPY deploy/grnet-zeus /etc/puppet/modules/zeus

ADD deploy/zeus.pp /srv/deploy/zeus.pp
RUN apt-get -y update
RUN cd /srv/deploy && puppet apply -v zeus.pp

RUN service gunicorn stop
RUN service postgresql stop
RUN service apache2 stop
RUN /etc/init.d/python-celery stop

ADD deploy/entrypoint.sh /srv/deploy/entrypoint.sh
RUN chmod +x /srv/deploy/entrypoint.sh

RUN service gunicorn stop
RUN service postgresql stop
RUN service apache2 stop
RUN /etc/init.d/python-celery stop

VOLUME /srv/data
VOLUME /srv/static

EXPOSE 80

ENTRYPOINT ["/bin/bash", "/srv/deploy/entrypoint.sh"]
CMD ["run"]
