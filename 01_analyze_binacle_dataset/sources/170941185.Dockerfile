FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade

RUN mkdir /tmp/islandora &&\
	cd /tmp/islandora &&\
	wget -O islandora_gsearch_module-7.x-1.10.zip "https://github.com/Islandora/islandora_solr_search/archive/7.x-1.10.zip" &&\
	unzip -o islandora_gsearch_module-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	sed -i 's|self::\$facet_dates = isset(\$islandora_solr_query->islandoraSolrResult)|self::$facet_dates = isset($islandora_solr_query->islandoraSolrResult['"'"'facet_counts'"'"']['"'"'facet_dates'"'"'])|g' /var/www/html/flat/sites/all/modules/contrib/islandora_solr_search-7.x-1.10/includes/results.inc
ADD drupal/flat_search /var/www/html/$FLAT_NAME/sites/all/modules/custom/

RUN	service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_solr -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_solr_config -y &&\
	/var/www/composer/vendor/drush/drush/drush en flat_search -y &&\
    /var/www/composer/vendor/drush/drush/drush vset islandora_basic_collection_display_backend islandora_solr_query_backend -y &&\
    /var/www/composer/vendor/drush/drush/drush vset islandora_compound_object_thumbnail_child 0 -y &&\
    /var/www/composer/vendor/drush/drush/drush vset islandora_compound_object_show_compound_parents_in_breadcrumbs 1 -y &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	sleep 1

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
