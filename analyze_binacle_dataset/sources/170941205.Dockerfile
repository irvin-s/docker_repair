FROM		flat 
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN mkdir -p /tmp/islandora &&\
	mkdir -p /var/www/html/drupal/sites/all/modules/contrib

#
# enable HTTPS
#

RUN a2enmod ssl &&\
    a2enmod headers &&\
    a2ensite default-ssl

EXPOSE 443

# mod_shib

RUN apt-get update &&\
    apt-get -y dist-upgrade &&\
    apt-get -y install libapache2-mod-shib2

RUN /etc/init.d/shibd start &&\
	sleep 30 &&\
	/etc/init.d/shibd stop

ADD supervisor/supervisord-shib.conf /etc/supervisor/conf.d/    

RUN service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	/wait-tomcat.sh &&\
	supervisorctl status &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	/var/www/composer/vendor/drush/drush/drush en shib_auth -y &&\
	/var/www/composer/vendor/drush/drush/drush vset shib_auth_full_handler_url "http://${FLAT_HOST}/Shibboleth.sso/Login" &&\
	/var/www/composer/vendor/drush/drush/drush vset shib_auth_full_logout_url "http://${FLAT_HOST}/Shibboleth.sso/Logout" &&\
	/var/www/composer/vendor/drush/drush/drush vset shib_auth_enable_custom_mail "1" &&\
	/var/www/composer/vendor/drush/drush/drush vset shib_auth_login_url "/islandora" &&\
	/var/www/composer/vendor/drush/drush/drush sqlq "INSERT INTO shib_auth (field,regexpression,role,sticky) VALUES ('REMOTE_USER','.%2B','a:1:{i:0;s:1:"'"2"'";}',1);" &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	sleep 1

# configure for interaction with the sso-demo IdP

ADD sso-demo/shibboleth2.xml /etc/shibboleth/shibboleth2.xml
ADD sso-demo/attribute-map.xml /etc/shibboleth/attribute-map.xml
ADD sso-demo/sso-demo-metadata.xml /etc/shibboleth/sso-demo-metadata.xml
RUN echo "# put FLAT behind shibboleth" >> /etc/apache2/apache2.conf &&\
	echo "<Location /${FLAT_NAME}>" >> /etc/apache2/apache2.conf &&\
    echo " AuthType            shibboleth" >> /etc/apache2/apache2.conf &&\
    echo " ShibRequireSession  Off" >> /etc/apache2/apache2.conf &&\
    echo " ShibUseHeaders      On" >> /etc/apache2/apache2.conf &&\
    echo " Satisfy             All" >> /etc/apache2/apache2.conf &&\
    echo " Require             shibboleth" >> /etc/apache2/apache2.conf &&\
	echo "</Location>" >> /etc/apache2/apache2.conf

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
