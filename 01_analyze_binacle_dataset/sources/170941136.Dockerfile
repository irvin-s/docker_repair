FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade &&\
	apt-get -y install ant

#
# Fedora GSearch
#

RUN mkdir -p /tmp/fedora-gsearch &&\
	cd /tmp/fedora-gsearch &&\
	wget -O fedoragsearch-2.8.zip "http://downloads.sourceforge.net/project/fedora-commons/services/3.7/fedoragsearch-2.8.zip?r=&use_mirror=heanet" &&\
	unzip "fedoragsearch-2.8.zip" && cp "fedoragsearch-2.8/fedoragsearch.war" "/var/www/fedora/tomcat/webapps/fedoragsearch.war" &&\
	mkdir /var/www/fedora/tomcat/webapps/fedoragsearch &&\
	cd /var/www/fedora/tomcat/webapps/fedoragsearch/ &&\
	unzip ../fedoragsearch.war &&\
	rm -r /tmp/fedora-gsearch
    
#
# SOLR
#

RUN mkdir -p /tmp/solr &&\
	cd /tmp/solr &&\
	wget "https://archive.apache.org/dist/lucene/solr/4.10.4/solr-4.10.4.zip" &&\
	unzip solr-4.10.4.zip &&\
	mkdir /var/www/fedora/solr && cp -r /tmp/solr/solr-4.10.4/example/solr/* /var/www/fedora/solr &&\
	sed -i 's/\.\.\/\.\.\/\.\.\//\.\.\//g' /var/www/fedora/solr/collection1/conf/solrconfig.xml  && cp -r /tmp/solr/solr-4.10.4/dist/ /var/www/fedora/solr && cp -r /tmp/solr/solr-4.10.4/contrib/ /var/www/fedora/solr && cp -r /tmp/solr/solr-4.10.4/example/webapps/solr.war /var/www/fedora/tomcat/webapps/solr.war &&\
	mkdir /var/www/fedora/tomcat/webapps/solr &&\
	cd /var/www/fedora/tomcat/webapps/solr/ &&\
	unzip ../solr.war && cp -r /tmp/solr/solr-4.10.4/example/lib/ext/* WEB-INF/lib &&\
	mkdir WEB-INF/classes && cp /tmp/solr/solr-4.10.4/example/resources/log4j.properties WEB-INF/classes &&\
	sed -ie "s|logs\/|$FEDORA_HOME\/server\/logs\/|g" WEB-INF/classes/log4j.properties &&\
	sed -i 's/RollingFileAppender/DailyRollingFileAppender/g' WEB-INF/classes/log4j.properties &&\
	sed -i '/MaxFileSize/d' WEB-INF/classes/log4j.properties &&\
	sed -i '/MaxBackupIndex/d' WEB-INF/classes/log4j.properties &&\
	sed -i 's/\/solr\.log/\/solr\.daily\.log/g' WEB-INF/classes/log4j.properties &&\
	sed -i 's/, CONSOLE//g' WEB-INF/classes/log4j.properties &&\
	rm -r /tmp/solr

#
# Configuration
#

ADD fedora/fedora-users.xml /var/www/fedora/server/config/fedora-users.xml
ADD gsearch/fgsconfig-basic-for-islandora.properties /var/www/fedora/tomcat/webapps/fedoragsearch/FgsConfig/fgsconfig-basic-for-islandora.properties
RUN	cd /var/www/fedora/tomcat/webapps/fedoragsearch/FgsConfig/ &&\
    sed -i "s|dk.defxws.fgssolr|dk.defxws.fgssolrremote|g" FgsConfigIndexTemplate/Solr/index.properties &&\
	ant -Dlocal.FEDORA_HOME=$FEDORA_HOME -f fgsconfig-basic.xml -propertyfile fgsconfig-basic-for-islandora.properties
ADD solr/solr.xml /var/www/fedora/tomcat/conf/Catalina/localhost/solr.xml
ADD solr/schema.xml $FEDORA_HOME/solr/collection1/conf/schema.xml
ADD solr/schema.xml $FEDORA_HOME/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/conf/flat-solr-schema.xml
ADD solr/solrcore.properties $FEDORA_HOME/solr/collection1/conf/solrcore.properties

#
# Discovery Garden: dgi_gsearch_extensions
#

RUN mkdir -p /tmp &&\
    cd /tmp &&\
    git clone -b v0.1.3 https://github.com/discoverygarden/dgi_gsearch_extensions.git &&\
    cd dgi_gsearch_extensions &&\
    mvn package && cp target/gsearch_extensions-0.1.3-jar-with-dependencies.jar $FEDORA_HOME/tomcat/webapps/fedoragsearch/WEB-INF/lib &&\
    rm -r /tmp/dgi_gsearch_extensions

#
# Discovery Garden: basic-solr-config
#

RUN mkdir -p /tmp &&\
    cd /tmp &&\
    git clone -b 4.x https://github.com/discoverygarden/basic-solr-config.git &&\
    cd /tmp/basic-solr-config &&\
	git checkout 3d741cd &&\
    git clone https://github.com/discoverygarden/islandora_transforms.git &&\
    cd /tmp/basic-solr-config/islandora_transforms &&\
    git checkout 5fe2b48 &&\
    cd /tmp/basic-solr-config &&\
    sed -i "s|/usr/local/fedora|$FEDORA_HOME|g" foxmlToSolr.xslt &&\
    sed -i "s|/usr/local/fedora|$FEDORA_HOME|g" islandora_transforms/slurp_all_MODS_to_solr.xslt &&\
    sed -i "s|/usr/local/fedora|$FEDORA_HOME|g" islandora_transforms/WORKFLOW_to_solr.xslt &&\
    cp foxmlToSolr.xslt /var/www/fedora/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/foxmlToSolr.xslt &&\
    cp -r islandora_transforms /var/www/fedora/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/ &&\
    rm -r /tmp/basic-solr-config
    
#
# Saxon
#

RUN mkdir /tmp/saxon &&\
    cd /tmp/saxon &&\
    wget -O SaxonHE9-7-0-2J.zip "http://downloads.sourceforge.net/project/saxon/Saxon-HE/9.7/SaxonHE9-7-0-2J.zip?r=&use_mirror=netix" &&\
    unzip "SaxonHE9-7-0-2J.zip" &&\
    mkdir -p /app/flat/lib/saxon &&\
    rm "SaxonHE9-7-0-2J.zip" &&\
    mv * /app/flat/lib/saxon/ &&\
    rm -r /tmp/saxon

#
# FindProfiles
#

RUN mkdir -p /tmp/FindProfiles
ADD flat/FindProfiles /tmp/FindProfiles
RUN cd /tmp/FindProfiles &&\
    mvn package &&\
    mv target/findProfiles.jar /app/flat/lib/findProfiles.jar
    
#
# CMD GSearch mapper
# 

RUN mkdir -p /app/flat/lib/cmd-gsearch
ADD flat/cmd-gsearch/* /app/flat/lib/cmd-gsearch/

RUN mkdir -p /app/flat/deposit/policies/
ADD flat/gsearch-mapping.xml /app/flat/deposit/policies/

#
# Add FLAT's own scripts and tools 
#

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh &&\
    mv /app/flat/bin/do-* /app/flat/

#Clean up APT when done.
RUN apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
