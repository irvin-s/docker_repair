FROM anroots/sensu-client:example

# Include Nagios plugins in the PATH
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/sensu/embedded/bin:/opt/nagios/plugins

# Install system-level dependencies needed to run nagios-plugins
# jwhois is not in debian repo (make install fails)
# pip install is not handled by make
# git is needed to download nagios plugins
RUN apt-get update && \
	apt-get install -y zlib1g-dev wget unzip python git && \
	wget https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py && \
	wget http://httpredir.debian.org/debian/pool/main/j/jwhois/jwhois_4.0-2.1_amd64.deb && \
	dpkg -i jwhois_4.0-2.1_amd64.deb && \
	rm jwhois_4.0-2.1_amd64.deb && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install nagios plugins and its dependencies
# This takes 10...20 minutes to run and results in ~350MB of space used
RUN mkdir /opt/nagios && \
	git clone https://github.com/harisekhon/nagios-plugins.git /opt/nagios/plugins && \
	cd /opt/nagios/plugins && \
	make
