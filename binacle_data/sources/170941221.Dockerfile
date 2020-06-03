FROM ubuntu:16.04
MAINTAINER  Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

#
# Configure FLAT
#

ENV FLAT_NAME=flat
#ENV FLAT_HOST=192.168.99.100
ENV FLAT_HOST=localhost
ENV FLAT_ICON_DIR=/app/flat/data/icons
ENV FLAT_TIMEOUT=150
ENV CMD_EXTENSION=cmdi
ENV FLAT_NAMESPACE=lat

#
# Setup workdir
#

RUN mkdir -p /app/flat/lib &&\
	mkdir -p /app/flat/bin &&\
	mkdir -p /app/flat/tmp

WORKDIR /app/flat

ENV HOME /root
ENV PATH="/app/flat/bin:${PATH}"

# expose ports

EXPOSE 80
EXPOSE 8080

#
# locale
#

ENV TZ 'Europe/Amsterdam'
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y locales && \
	sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG "en_US.UTF-8"
ENV LANGUAGE "en_US.UTF-8"
ENV LC_ALL "en_US.UTF-8"

#
# Update and install all system libraries
#
RUN apt-get update &&\
	apt-get -y dist-upgrade &&\
	apt-get -y install supervisor curl wget openssl apache2 postgresql unzip ssh rsync git

# PHP
RUN apt-get -y install libapache2-mod-php php-gd php-pgsql php-xsl php-curl

# Java 8
RUN apt-get -y install software-properties-common python-software-properties && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get -y install oracle-java8-installer maven
ENV JAVA_HOME "/usr/lib/jvm/java-8-oracle"

# dev
RUN apt-get -y install libxml2-utils vim

#
# Configure apache
#   - set apache ulimit to 1024
ADD apache/envvars /etc/apache2/envvars
ADD apache/apache2.conf /etc/apache2/apache2.conf
RUN a2enmod ssl &&\
	a2enmod rewrite &&\
	a2enmod proxy &&\
	a2enmod proxy_http &&\
	a2enmod sed &&\
	sed -i "s|FLAT_NAME|${FLAT_NAME}|g" /etc/apache2/apache2.conf

#
# Configure postgres
#   - initialise databases for fedora and drupal
ADD postgresql/wait-postgres.sh /wait-postgres.sh
ADD postgresql/wait-sergtsop.sh /wait-sergtsop.sh
RUN chmod u+x /wait-postgres.sh &&\
	chmod u+x /wait-sergtsop.sh &&\
    /etc/init.d/postgresql start &&\
	/wait-postgres.sh &&\
	su -c "psql -c \"CREATE USER fedora WITH PASSWORD 'fedora'\"" postgres &&\
	su -c "createdb -O fedora fedora" postgres &&\
	su -c "createdb -O fedora proai" postgres &&\
	su -c "createdb -O fedora --encoding=UNICODE -T template0 drupal" postgres &&\
	/etc/init.d/postgresql stop &&\
	/wait-sergtsop.sh

#
# Download packages for the islandora setup
#   - fedora commons
#   - proai
#   - drupal
#       - tuque
#   - islandora
#

ENV FEDORA_HOME /var/www/fedora
ENV CATALINA_HOME /var/www/fedora/tomcat

RUN mkdir /tmp/fedora &&\
	cd /tmp/fedora &&\
	wget "https://github.com/fcrepo3/fcrepo/releases/download/v3.8.1/fcrepo-installer-3.8.1.jar"

ADD fedora/install.properties /tmp/fedora/install.properties
RUN /etc/init.d/postgresql start &&\
	/wait-postgres.sh &&\
	cd /tmp/fedora &&\
	java -jar fcrepo-installer-3.8.1.jar install.properties &&\
	/etc/init.d/postgresql stop &&\
	/wait-sergtsop.sh

# tell fedora about CMDI
RUN sed -i 's|</mappings>|<mime-mapping><mime-type>application/x-cmdi+xml</mime-type><extension>cmdi</extension></mime-mapping></mappings>|g' /var/www/fedora/server/config/mime-to-extensions.xml

#
# All services are installed, add start script to automatically start required services
#

ADD flat.txt /flat.txt
ADD supervisor/start-*.sh /
RUN	chmod u+x /start-*.sh
ADD supervisor/*.conf /etc/supervisor/conf.d/
ADD supervisor/start.sh /start.sh
RUN	chmod u+x /start.sh
RUN echo ". /etc/environment" >> /etc/default/supervisor

ENTRYPOINT /start.sh

#
# starting fedora will initialize required directories
#

ADD fedora/wait-tomcat.sh /wait-tomcat.sh
RUN chmod u+x /wait-tomcat.sh &&\
    service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	/wait-sergtsop.sh

# policies
RUN rm -v /var/www/fedora/data/fedora-xacml-policies/repository-policies/default/deny-purge-*
RUN rm -v /var/www/fedora/data/fedora-xacml-policies/repository-policies/default/deny-policy-management-if-not-administrator.xml
RUN rm -v /var/www/fedora/data/fedora-xacml-policies/repository-policies/default/deny-inactive-or-deleted-objects-or-datastreams-if-not-administrator.xml
ADD fedora/deny-deleted-objects-or-datastreams-if-not-administrator.xml /var/www/fedora/data/fedora-xacml-policies/repository-policies/default/deny-deleted-objects-or-datastreams-if-not-administrator.xml
ADD fedora/permit-anything-to-localhost.xml /var/www/fedora/data/fedora-xacml-policies/repository-policies/default/permit-anything-to-localhost.xml
ADD fedora/deny-unallowed-file-resolution.xml /var/www/fedora/data/fedora-xacml-policies/repository-policies/default/deny-unallowed-file-resolution.xml
RUN cd /var/www/fedora/data/fedora-xacml-policies/repository-policies/ &&\
	wget https://github.com/Islandora/islandora-xacml-policies/archive/master.zip &&\
	unzip master.zip &&\
	rm master.zip &&\
	mv islandora-xacml-policies-master islandora

# authorisation filter
RUN cd /var/www/fedora/tomcat/webapps/fedora/WEB-INF/lib &&\
	wget "https://github.com/Islandora/islandora_drupal_filter/releases/download/7.1.10/fcrepo-drupalauthfilter-3.8.1.jar"
ADD fedora/jaas.conf /var/www/fedora/server/config/jaas.conf
ADD fedora/filter-drupal.xml /var/www/fedora/server/config/filter-drupal.xml

##Download and configure drupal (via drush)
RUN mkdir -p /var/www/composer &&\
	cd /var/www/composer &&\
	curl -sS https://getcomposer.org/installer | php &&\
	mv composer.phar composer
ENV COMPOSER_HOME=/var/www/composer
RUN $COMPOSER_HOME/composer global require drush/drush:7.*

RUN cd /var/www/html &&\
	/var/www/composer/vendor/drush/drush/drush -v dl drupal --drupal-project-rename=$FLAT_NAME
ENV PGPASSWORD=fedora
RUN service supervisor start &&\
    /wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	cd /var/www/html/$FLAT_NAME &&\
	export PHP_OPTIONS="-d sendmail_path=`which true`" &&\
	/var/www/composer/vendor/drush/drush/drush site-install standard --site-name=FLAT --account-name=admin --account-pass=admin --db-su=fedora --db-su-pw=fedora --db-url=pgsql://fedora:fedora@localhost/drupal -y &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	/wait-sergtsop.sh

RUN mkdir -p /var/www/html/$FLAT_NAME/sites/all/modules/custom &&\
	chown www-data:www-data /var/www/html/$FLAT_NAME/sites/default/files &&\
	chown www-data:www-data /var/www/html/$FLAT_NAME/sites/default/settings.php &&\
	chown www-data:www-data /var/www/html/$FLAT_NAME/sites/all/modules/custom
    
ADD drupal/flat-logo.png /var/www/html/$FLAT_NAME/sites/default/files/flat-logo.png
ADD drupal/flat /var/www/html/$FLAT_NAME/sites/all/modules/custom/
ADD drupal/flat-logo.php /tmp/

# To check accessibility we use a HEAD request using the http(s)?://<user>:<pass>@<host>(:<port>)?/<path>... support of drupal_http_request
# however if the username or password does contain funny characters no escaping is supported
# this change allows to use rawurlencode, as drupal_http_request will now do a rawurldecode
RUN sed -i "s|base64_encode(\$uri\['user'\]|base64_encode(rawurldecode(\$uri['user'])|g" /var/www/html/$FLAT_NAME/includes/common.inc &&\
	sed -i "s| \$uri\['pass'\] | rawurldecode(\$uri['pass']) |g" /var/www/html/$FLAT_NAME/includes/common.inc

RUN mkdir /tmp/tuque &&\
	cd /tmp/tuque &&\
	wget "https://github.com/islandora/tuque/archive/1.10.zip" &&\
	unzip 1.10.zip &&\
	mv /tmp/tuque/tuque-1.10 /var/www/html/$FLAT_NAME/sites/all/libraries/tuque &&\
	sed -i 's|public $verifyPeer = TRUE;|public $verifyPeer = FALSE;|g' /var/www/html/$FLAT_NAME/sites/all/libraries/tuque/HttpConnection.php

RUN mkdir -p /tmp/islandora &&\
	mkdir -p /var/www/html/$FLAT_NAME/sites/all/modules/contrib &&\
	mkdir -p /var/www/html/$FLAT_NAME/sites/all/themes &&\
	cd /tmp/islandora &&\
	wget "https://github.com/Islandora/islandora/archive/7.x-1.10.tar.gz" &&\
	tar -xf 7.x-1.10.tar.gz -C /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /tmp/islandora &&\
	wget -O islandora_solution_pack_collection-7.x-1.10.zip "https://github.com/islandora/islandora_solution_pack_collection/archive/7.x-1.10.zip" &&\
	unzip islandora_solution_pack_collection-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /tmp/islandora &&\
	wget -O islandora_xacml_editor-7.x-1.10.zip "https://github.com/Islandora/islandora_xacml_editor/archive/7.x-1.10.zip" &&\
	unzip islandora_xacml_editor-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
	cd /tmp/islandora &&\
	wget -O islandora_solution_pack_compound-7.x-1.10.zip "https://github.com/Islandora/islandora_solution_pack_compound/archive/7.x-1.10.zip" &&\
	unzip islandora_solution_pack_compound-7.x-1.10.zip -d /var/www/html/$FLAT_NAME/sites/all/modules/contrib/ &&\
    sed -i 's|function islandora_compound_object_islandora_compoundCModel_islandora_view_object|function islandora_compound_object_islandora_compoundCModel_islandora_view_object_DISABLED_BY_FLAT|g' /var/www/html/$FLAT_NAME/sites/all/modules/contrib/islandora_solution_pack_compound-7.x-1.10/islandora_compound_object.module
# overwrites the collection object view, so we get file details
ADD islandora/islandora_basic_collection.module /var/www/html/flat/sites/all/modules/contrib/islandora_solution_pack_collection-7.x-1.10/islandora_basic_collection.module

# add CMDI solution pack
RUN mkdir -p /var/www/html/$FLAT_NAME/sites/all/modules/contrib/islandora_solution_pack_cmdi
ADD flat/islandora_solution_pack_cmdi /var/www/html/$FLAT_NAME/sites/all/modules/contrib/islandora_solution_pack_cmdi

# tell islandora about CMDI
RUN sed -i "/\"json\"/a \"cmdi\" => \"application/x-cmdi+xml\"," /var/www/html/$FLAT_NAME/sites/all/modules/contrib/islandora-7.x-1.10/includes/mimetype.utils.inc &&\
	sed -i "/header('Content-type: ' . \$datastream/a if (\$datastream->ID == 'CMD') {\nheader('Content-type: ' . 'application/xml');\n}" /var/www/html/$FLAT_NAME/sites/all/modules/contrib/islandora-7.x-1.10/includes/datastream.inc
    
RUN mkdir -p /tmp/bootstrap &&\
	cd /tmp/bootstrap &&\
	wget "https://ftp.drupal.org/files/projects/bootstrap-7.x-3.14.zip" &&\
	unzip bootstrap-7.x-3.14.zip &&\
	mv /tmp/bootstrap/bootstrap /var/www/html/$FLAT_NAME/sites/all/themes/bootstrap

RUN cp -r /var/www/html/$FLAT_NAME/sites/all/themes/bootstrap/starterkits/cdn  /var/www/html/$FLAT_NAME/sites/all/themes/flat_bootstrap_theme &&\
	cd /var/www/html/$FLAT_NAME/sites/all/themes/flat_bootstrap_theme/ &&\
	mv cdn.starterkit flat_bootstrap_theme.info &&\
    echo ";; FLAT settings" >> flat_bootstrap_theme.info &&\
	echo "settings[bootstrap_cdn_jsdelivr_theme] = 'flatly'" >> flat_bootstrap_theme.info &&\
    echo "settings[bootstrap_fluid_container] = 1" >> flat_bootstrap_theme.info &&\
	mkdir -p /var/www/html/$FLAT_NAME/sites/all/themes/flat_bootstrap_theme/js
# determine our own object view
ADD islandora/islandora-default.tpl.php /var/www/html/$FLAT_NAME/sites/all/themes/flat_bootstrap_theme/templates/islandora-default.tpl.php
# overwrite the compound behavior, which does special things for the first member (as being the representative)
ADD islandora/template.php /var/www/html/$FLAT_NAME/sites/all/themes/flat_bootstrap_theme/template.php
ADD islandora/flat.js /var/www/html/$FLAT_NAME/sites/all/themes/flat_bootstrap_theme/js/flat.js

RUN service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	/var/www/composer/vendor/drush/drush/drush vset islandora_base_url http://localhost:8080/fedora &&\
	/var/www/composer/vendor/drush/drush/drush en islandora -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_xacml_editor -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_basic_collection -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_compound_object -y &&\
	/var/www/composer/vendor/drush/drush/drush en islandora_cmdi -y &&\
	/var/www/composer/vendor/drush/drush/drush vset islandora_metadata_display cmdi &&\
	/var/www/composer/vendor/drush/drush/drush dl features_extra -y &&\
	/var/www/composer/vendor/drush/drush/drush en flat -y &&\
	/var/www/composer/vendor/drush/drush/drush php-script flat-logo --script-path=/tmp &&\
	/var/www/composer/vendor/drush/drush/drush en jquery_update -y &&\
	/var/www/composer/vendor/drush/drush/drush en bootstrap -y &&\
	/var/www/composer/vendor/drush/drush/drush en flat_bootstrap_theme -y &&\
	/var/www/composer/vendor/drush/drush/drush vset theme_default flat_bootstrap_theme &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	/wait-sergtsop.sh

#
# Add LAT2FOX
#

ENV MAVEN_OPTS -Xss10M

RUN cd /tmp &&\
    git clone -b develop https://github.com/TheLanguageArchive/SchemAnon.git SchemAnon &&\
    cd /tmp/SchemAnon &&\
    mvn clean install &&\
    mv target/SchemAnon.jar /app/flat/lib/SchemAnon.jar

RUN mkdir -p /tmp/LAT2FOX
ADD flat/LAT2FOX /tmp/LAT2FOX
RUN cd /tmp/LAT2FOX &&\
    mvn clean package &&\
    mv target/lat2fox.jar /app/flat/lib/lat2fox.jar
	
#
# Add FLAT's own scripts, tools and icons
#

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh &&\
    mv /app/flat/bin/do-*.sh /app/flat/

RUN mkdir -p /app/flat/deposit
ADD flat/policies /app/flat/deposit/policies
ADD flat/policies-private-resources /app/flat/deposit/policies-private-resources
ADD flat/policies /app/flat/deposit/policies

RUN mkdir -p $FLAT_ICON_DIR
ADD flat/icons $FLAT_ICON_DIR
    
#
# Cleanup
#

# clean up APT and /tmp when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
