FROM        flat
MAINTAINER  Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

#
# Update and install all system libraries
#
RUN apt-get update &&\
	apt-get -y dist-upgrade

#
# ISLE2CLARIN 
#

ADD proai/proai.properties /var/www/fedora/tomcat/webapps/oaiprovider/WEB-INF/classes/proai.properties

RUN cd /tmp &&\
    git clone https://github.com/TheLanguageArchive/ISLE2CLARIN.git ISLE2CLARIN &&\
    cd /tmp/ISLE2CLARIN &&\
    mvn clean package &&\
    mkdir -p /app/flat/lib &&\
    mv target/isle2clarin.jar /app/flat/lib/isle2clarin.jar
    

RUN mkdir -p /app/flat/deposit/policies/
ADD flat/*.* /app/flat/deposit/policies/

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh &&\
	mv /app/flat/bin/do-*.sh /app/flat/

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
