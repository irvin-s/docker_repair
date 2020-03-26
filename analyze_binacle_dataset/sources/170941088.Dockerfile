FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade &&\
	apt-get -y install file
# mediainfo

#
# FITS
#

ADD fits /tmp/fits
RUN ls /tmp/
RUN cd /tmp/fits &&\
    if [ ! -f fits-1.4.0.zip ]; then wget https://github.com/harvard-lts/fits/releases/download/1.4.0/fits-1.4.0.zip; fi &&\
    unzip fits-1.4.0.zip &&\
    mkdir -p /app/fits &&\
    mv * /app/fits/ &&\
    mkdir /app/fits/log-lib &&\
    mv /app/fits/lib/slf4j-log4j12-1.7.22.jar /app/fits/log-lib &&\
    sed -i 's|APPCLASSPATH=""|APPCLASSPATH="${FITS_HOME}/log-lib/slf4j-log4j12-1.7.22.jar"|g' /app/fits/fits-env.sh &&\
    chmod +x /app/fits/*.sh &&\
    wget http://projects.iq.harvard.edu/files/fits/files/fits-1.1.3.war &&\
    cp fits-1.1.3.war /var/www/fedora/tomcat/webapps/fits.war &&\
    mkdir /var/www/fedora/tomcat/webapps/fits &&\
    cd /var/www/fedora/tomcat/webapps/fits &&\
    unzip -n ../fits.war &&\
    echo "fits.home=/app/fits" >> $CATALINA_HOME/conf/catalina.properties &&\
    echo 'shared.loader=${fits.home}/lib/*.jar' >> $CATALINA_HOME/conf/catalina.properties &&\
    ln -s /app/fits/fits.sh /app/flat/bin/fits.sh

#
# The FLAT Doorkeeper
#

RUN cd /tmp &&\
    git clone https://github.com/menzowindhouwer/fedora-cargo-plugin.git fedora-cargo-plugin &&\
    cd /tmp/fedora-cargo-plugin &&\
    mvn clean install

RUN cd /tmp &&\
    git clone https://github.com/menzowindhouwer/fedora-client.git fedora-client &&\
    cd /tmp/fedora-client &&\
    mvn -DskipTests clean install

RUN cd /tmp &&\
    git clone -b 1.0.1 https://github.com/meertensinstituut/EPICify.git epicify &&\
    cd /tmp/epicify &&\
    mvn clean install &&\
    cp cli/target/epicify.jar /app/flat/lib/

ADD DoorKeeper /tmp/DoorKeeper
RUN cd /tmp &&\
    if [ ! -f /tmp/DoorKeeper/pom.xml ]; then rm -rf DoorKeeper;  git clone -b develop https://github.com/TLA-FLAT/DoorKeeper.git DoorKeeper; fi &&\
    cd /tmp/DoorKeeper &&\
    mvn clean install

ADD flat/deposit/ServiceFLAT /tmp/ServiceFLAT
RUN cd /tmp/ServiceFLAT &&\
    mvn clean install &&\
    cp target/flat.war /var/www/fedora/tomcat/webapps/flat.war &&\
    mkdir /var/www/fedora/tomcat/webapps/flat &&\
    cd /var/www/fedora/tomcat/webapps/flat &&\
    unzip ../flat.war &&\
    cp /tmp/ServiceFLAT/logging.properties /var/www/fedora/tomcat/webapps/flat/WEB-INF/classes/logging.properties
    
RUN if [ `grep 'environment=' /etc/supervisor/conf.d/supervisord-tomcat.conf` ]; \
      then sed -i 's|^environment=\(.*\)$|environment=\1,FLAT_ICON_DIR=%(ENV_FLAT_ICON_DIR)s,FLAT_NAMESPACE=%(ENV_FLAT_NAMESPACE)s|g' /etc/supervisor/conf.d/supervisord-tomcat.conf; \
      else echo '' >> /etc/supervisor/conf.d/supervisord-tomcat.conf; echo 'environment=FLAT_ICON_DIR=%(ENV_FLAT_ICON_DIR)s,FLAT_NAMESPACE=%(ENV_FLAT_NAMESPACE)s' >> /etc/supervisor/conf.d/supervisord-tomcat.conf; \
    fi &&\
    echo "export FLAT_ICON_DIR=$FLAT_ICON_DIR" >> /etc/environment &&\
    echo "export FLAT_NAMESPACE=$FLAT_NAMESPACE" >> /etc/environment

# Add proxy to Apache

RUN echo '# open up access to the DoorKeeper' >> /etc/apache2/apache2.conf &&\ 
    echo 'ProxyPass "/'${FLAT_NAME}'/doorkeeper" "http://localhost:8080/flat/doorkeeper"' >> /etc/apache2/apache2.conf

RUN mkdir -p /app/flat/deposit/easy
RUN mkdir -p /app/flat/data
ADD flat/deposit/flat-deposit.xml /app/flat/deposit/flat-deposit.xml
ADD flat/deposit/policies /app/flat/deposit/policies
RUN mkdir -p /app/flat/deposit/bags &&\
    mkdir -p /app/flat/deposit/transforms &&\
    cd /app/flat/deposit/transforms &&\
    jar xf /app/flat/lib/lat2fox.jar cmd2fox.xsl

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh

#Clean up APT when done.
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* 
