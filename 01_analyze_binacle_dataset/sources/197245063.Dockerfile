####
# Netflow collector and local processing container
# using NFSen and NFDump for processing. This can
# be run standalone or in conjunction with a analytics
# engine that will perform time based graphing and
# stats summarization.
###

FROM debian:latest
MAINTAINER Brent Salisbury <brent.salisbury@gmail.com

RUN apt-get update
RUN apt-get install -y \
    gcc \
    flex \
    rrdtool \
    apache2 \
    tcpdump \
    wget \
    php5 \
    apache2 \
    librrd-dev \
    libapache2-mod-php5 \
    php5-common \
    libio-socket-inet6-perl \
    libio-socket-ssl-perl \
    libmailtools-perl \
    librrds-perl \
    libwww-perl \
    libipc-run-perl \
    perl-base \
    libsys-syslog-perl \
    supervisor \
    net-tools

# Cleanup apt-get cache
RUN apt-get clean

# Apache
EXPOSE 80
# NetFlow
EXPOSE 2055
# IPFIX
EXPOSE 4739
# sFlow
EXPOSE 6343
# nfsen src ip src node mappings per example
EXPOSE 9996

# mk some dirs
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor

# Example ENV variable injection if you want to add collector addresses
ENV NFSEN_VERSION 1.3.7
ENV NFDUMP_VERSION 1.6.13

# Install NFDump (note the random redirected DL server from sourceforge. Their redirects are awful
# so using the only 302 redirect that is the closest to almost working every time...
RUN cd /usr/local/src && \
    wget  http://iweb.dl.sourceforge.net/project/nfdump/stable/nfdump-${NFDUMP_VERSION}/nfdump-${NFDUMP_VERSION}.tar.gz && \
	tar xfz nfdump-${NFDUMP_VERSION}.tar.gz && cd nfdump-${NFDUMP_VERSION}/ && \
	./configure \
	 --enable-nfprofile \
	--with-rrdpath=/usr/bin \
	--enable-nftrack \
	--enable-sflow && \
	make && make install

# Configure php with the systems timezone, modifications are tagged with the word 'NFSEN_OPT' for future ref
# Recommended leaving the timezone as UTC as NFSen and NFCapd timestamps need to be in synch.
# Timing is also important for the agregates time series viewer for glabal visibility and analytics.
RUN sed -i 's/^;date.timezone =/date.timezone \= \"UTC\"/g' /etc/php5/apache2/php.ini
RUN sed -i '/date.timezone = "UTC\"/i ; NFSEN_OPT Adjust your timezone for nfsen' /etc/php5/apache2/php.ini
RUN sed -i 's/^;date.timezone =/date.timezone \= \"UTC\"/g' /etc/php5/cli/php.ini
RUN sed -i '/date.timezone = "UTC\"/i ; NFSEN_OPT Adjust your timezone for nfsen' /etc/php5/cli/php.ini

# Configure NFSen config files
RUN mkdir -p /data/nfsen
WORKDIR /data
RUN wget http://iweb.dl.sourceforge.net/project/nfsen/stable/nfsen-${NFSEN_VERSION}/nfsen-${NFSEN_VERSION}.tar.gz
RUN tar xfz nfsen-${NFSEN_VERSION}.tar.gz
RUN sed -i 's/"www";/"www-data";/g' nfsen-${NFSEN_VERSION}/etc/nfsen-dist.conf
# Example how to fill in any flow source you want using | as a delimiter. Sort of long and gross though.
# Modify the pre-defined NetFlow v5/v9 line matching the regex 'upstream1'
RUN sed -i  "s|'upstream1'    => { 'port' => '9995', 'col' => '#0000ff', 'type' => 'netflow' },|'netflow-global'  => { 'port' => '2055', 'col' => '#0000ff', 'type' => 'netflow' },|g"  nfsen-${NFSEN_VERSION}/etc/nfsen-dist.conf
# Bind port 6343 and an entry for  sFlow collection
RUN sed  -i "/%sources/a \\    'sflow-global'  => { 'port' => '6343', 'col' => '#0000ff', 'type' => 'sflow' }," nfsen-${NFSEN_VERSION}/etc/nfsen-dist.conf
# Bind port 4739 and an entry for IPFIX collection. E.g. NetFlow v10
RUN sed  -i "/%sources/a \\    'ipfix-global'  => { 'port' => '4739', 'col' => '#0000ff', 'type' => 'netflow' }," nfsen-${NFSEN_VERSION}/etc/nfsen-dist.conf

# Add an account for NFSen as a member of the apache group
RUN useradd -d /var/netflow -G www-data -m -s /bin/false netflow

# Run the nfsen installer
WORKDIR /data/nfsen-${NFSEN_VERSION}
RUN perl ./install.pl etc/nfsen-dist.conf || true
RUN sleep 3

WORKDIR /
# Add startup script for nfsen profile init
ADD ./start.sh /data/start.sh
# flow-generator binary for testing
ADD ./flow-generator /data/flow-generator
ADD	./supervisord.conf /etc/supervisord.conf

CMD bash -C '/data/start.sh'; '/usr/bin/supervisord'
