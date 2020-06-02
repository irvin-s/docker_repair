#
# Salt Stack Salt Master Container
#

FROM ubuntu:14.04
MAINTAINER SOON_ <dorks@thisissoon.com>

# Update System
RUN apt-get update && apt-get upgrade -y -o DPkg::Options::=--force-confold

# Add PPA

RUN apt-get install -y software-properties-common dmidecode
RUN add-apt-repository -y ppa:saltstack/salt
RUN apt-get update

# Install Salt

RUN apt-get install -y salt-master=2014.1.11+ds-2trusty1

# Volumes

VOLUME ['/etc/salt/pki', '/var/cache/salt', '/var/logs/salt', '/etc/salt/master.d', '/srv/salt']

# Add Run File

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Ports

EXPOSE 4505 4506

# Run Command

CMD "/usr/local/bin/run.sh"
