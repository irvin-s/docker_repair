FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN mkdir -p /tmp/islandora &&\
	mkdir -p /var/www/html/$FLAT_NAME/sites/all/modules/contrib

#
# Audio solution pack
#

RUN apt-get update &&\
    apt-get -y dist-upgrade &&\
    apt-get -y install lame libmp3lame0
    
RUN cd /tmp/islandora &&\
	wget "https://github.com/Islandora/islandora_solution_pack_audio/archive/7.x-1.10.zip" &&\
	mv 7.x-1.10.zip islandora_solution_pack_audio-7.x-1.10.zip &&\
	unzip islandora_solution_pack_audio-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	export PGPASSWORD=fedora &&\
	service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_audio -y &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	sleep 1
    
#
# Islandora Batch Derivative Trigger and its dependencies
#

RUN service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	cd /tmp/islandora &&\
	wget "https://github.com/Islandora/php_lib/archive/7.x-1.10.zip" &&\
	mv 7.x-1.10.zip php_lib-7.x-1.10.zip &&\
	unzip php_lib-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /tmp/islandora &&\
	wget "https://github.com/Islandora/objective_forms/archive/7.x-1.10.zip" &&\
	mv 7.x-1.10.zip objective_forms-7.x-1.10.zip &&\
	unzip objective_forms-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /tmp/islandora &&\
	wget "https://github.com/Islandora/islandora_xml_forms/archive/7.x-1.10.zip" &&\
	mv 7.x-1.10.zip islandora_xml_forms-7.x-1.10.zip &&\
	unzip islandora_xml_forms-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /tmp/islandora &&\
	wget "https://github.com/qadan/islandora_batch_derivative_trigger/archive/7.x.zip" &&\
	mv 7.x.zip islandora_batch_derivative_trigger-7.x.zip &&\
	unzip islandora_batch_derivative_trigger-7.x.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	/var/www/composer/vendor/drush/drush/drush en php_lib -y &&\
	/var/www/composer/vendor/drush/drush/drush en objective_forms -y &&\
	/var/www/composer/vendor/drush/drush/drush en xml_form_builder -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_batch_derivative_trigger -y &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	sleep 1

#
# Add FLAT's own scripts and tools 
#

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh &&\
	mv /app/flat/bin/do-*.sh /app/flat/

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
