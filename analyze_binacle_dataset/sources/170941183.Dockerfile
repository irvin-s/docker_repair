FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade

# Islandora OAI

RUN mkdir -p /tmp/islandora &&\
	cd /tmp/islandora &&\
	wget -O islandora_oai_module-7.x-1.10.zip "https://github.com/Islandora/islandora_oai/archive/7.x-1.10.zip" &&\
	unzip islandora_oai_module-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/

# Module to add CMD as output format to the Islandora OAI provider

RUN mkdir -p /tmp/islandora &&\
	cd /tmp/islandora &&\
	git clone https://github.com/TLA-FLAT/islandora_oai_cmdi_olac.git &&\
	mv islandora_oai_cmdi_olac /var/www/html/$FLAT_NAME/sites/all/modules/contrib/

# enable Islandora (CMD) OAI

RUN	service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_oai -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_oai_cmdi_olac -y &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	/wait-sergtsop.sh

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
