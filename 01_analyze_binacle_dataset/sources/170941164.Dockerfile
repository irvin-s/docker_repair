FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade &&\
	apt-get -y install ant
	
#
# SOLR configuration
#

ADD drupal/flat_imdi_search /var/www/html/$FLAT_NAME/sites/all/modules/custom/

RUN service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	/var/www/composer/vendor/drush/drush/drush en flat_imdi_search -y &&\
	/var/www/composer/vendor/drush/drush/drush vset islandora_solr_limit_result_fields 1 &&\
	/var/www/composer/vendor/drush/drush/drush vset islandora_solr_query_fields 'dc.title^5 dc.subject^2 dc.description^2 cmd.fulltext^2 dc.creator^2 dc.contributor^1 dc.type' &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	sleep 1

#
# CMD GSearch mapping
#

RUN mkdir -p /app/flat/deposit/policies/
ADD flat/gsearch-mapping-template.xml /app/flat/deposit/policies/gsearch-mapping.xml

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
