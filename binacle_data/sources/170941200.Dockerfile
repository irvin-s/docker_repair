FROM flat
MAINTAINER  Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

#
# Update and install all system libraries
#
RUN apt-get update &&\
	apt-get -y dist-upgrade

#
# proai
#

RUN mkdir /tmp/proai &&\
	cd /tmp/proai &&\
	wget http://downloads.sourceforge.net/project/fedora-commons/services/3.4/oaiprovider-1.2.2.zip &&\
	unzip oaiprovider-1.2.2.zip &&\
	cp oaiprovider-1.2.2/oaiprovider.war /var/www/fedora/tomcat/webapps/oaiprovider.war &&\
	mkdir -p /var/www/fedora/tomcat/webapps/oaiprovider &&\
	cd /var/www/fedora/tomcat/webapps/oaiprovider &&\
	jar xf ../oaiprovider.war
ADD proai/proai.properties /var/www/fedora/tomcat/webapps/oaiprovider/WEB-INF/classes/proai.properties
ADD proai/identify.xml /var/www/html/identify.xml
RUN echo "# open up access to the OAI provider" >> /etc/apache2/apache2.conf &&\
    echo "ProxyPreserveHost On" >> /etc/apache2/apache2.conf &&\
    echo "ProxyPass "'"'"/${FLAT_NAME}/oaiprovider"'"'" "'"'"http://localhost:8080/oaiprovider"'"' >> /etc/apache2/apache2.conf &&\
    echo "<Location "'"'"/${FLAT_NAME}/oaiprovider"'"'">" >> /etc/apache2/apache2.conf &&\
    echo "    SetOutputFilter Sed" >> /etc/apache2/apache2.conf &&\
    echo "    OutputSed "'"'"s,>http\(s\{0,1\}\)://\([^/]*\)/oaiprovider,>http\1://\2/${FLAT_NAME}/oaiprovider,g"'"' >> /etc/apache2/apache2.conf &&\
    echo "</Location>" >> /etc/apache2/apache2.conf

#
# Add FLAT's own scripts
#

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh &&\
	mv /app/flat/bin/do-*.sh /app/flat/

#
# Cleanup
#

# clean up APT and /tmp when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
