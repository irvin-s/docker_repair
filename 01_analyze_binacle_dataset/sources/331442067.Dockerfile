FROM ubuntu:16.04
MAINTAINER Xavier Mertens <xavier@rootshell.be>

# Install prerequisites for moloch

RUN apt-get -qq update
RUN apt-get install -yq curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get -qq update && apt-get -qq upgrade
RUN apt-get install -yq  wget curl git sudo libyaml-dev xz-utils gcc pkg-config  g++ flex bison \
			zlib1g-dev libffi-dev gettext libpcre3-dev uuid-dev libmagic-dev \
			libgeoip-dev make libjson-perl libbz2-dev libwww-perl libpng-dev yara \
			libpcap-dev nodejs phantomjs vim net-tools python supervisor socat openssl \
			tcpdump

ADD /scripts /data
RUN chmod 755 /data/*.sh

# Start building Moloch
RUN /data/buildmoloch.sh /data/moloch-git  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN ln -s /usr/bin/nodejs /data/moloch/bin/node
RUN ln -s /data/moloch/bin/moloch-capture /usr/bin/moloch-capture
RUN ln -s /data/moloch/bin/moloch-capture /usr/bin/capture

RUN touch /.firstboot

ADD /etc /tmp

VOLUME ["/data/moloch/etc","/data/moloch/logs","/data/moloch/data","/data/moloch/raw","/data/pcap"]

# Set expose port for moloch viewer & socat
EXPOSE 8005
EXPOSE 8443

WORKDIR /data/moloch

ENTRYPOINT ["/data/startmoloch.sh"]
