FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade &&\
	update-ca-certificates -f &&\
	apt-get -y install --reinstall ca-certificates-java 

ENV FLAT_NAMESPACE=comic
RUN echo "export FLAT_NAMESPACE=$FLAT_NAMESPACE" >> /etc/environment

# add sample SIP
RUN mkdir -p /app/flat/test
ADD flat/deposit/test/icons/* $FLAT_ICON_DIR/
ADD flat/deposit/test/*.* /app/flat/test/
ADD flat/deposit/test/cmd /app/flat/test/cmd
ADD flat/deposit/test/data /app/flat/test/data
ADD flat/deposit/test/policies /app/flat/test/policies
ADD flat/deposit/test/test-sip /app/flat/test/test-sip
ADD flat/deposit/test/test-sip-update /app/flat/test/test-sip-update
ADD flat/deposit/test/test-sip-delete /app/flat/test/test-sip-delete

# add sample user(s)
RUN	service supervisor start &&\
	/wait-postgres.sh &&\
	supervisorctl start tomcat &&\
	FLAT_TIMEOUT=`expr 10 \* $FLAT_TIMEOUT` /wait-tomcat.sh &&\
	cd /var/www/html/$FLAT_NAME/ &&\
	export PGPASSWORD=fedora &&\
	/var/www/composer/vendor/drush/drush/drush user-create "john@example.com" --mail="john@example.com" --password="password" -y &&\
	/var/www/composer/vendor/drush/drush/drush user-create "jane@example.com" --mail="jane@example.com" --password="password" -y &&\
	supervisorctl stop all &&\
	service supervisor stop &&\
	/wait-sergtsop.sh

#
# Add FLAT's own scripts and tools 
#

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh &&\
    mv /app/flat/bin/do-* /app/flat/ &&\
    mv /app/flat/bin/do.sh /app/flat/do.sh &&\
	mkdir -p /app/flat/deposit/cache/schemas

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /var/tmp/*
# /tmp/*
