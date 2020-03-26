FROM		flat
MAINTAINER	Menzo Windhouwer <menzo.windhouwer@meertens.knaw.nl>

RUN apt-get update &&\
	apt-get -y dist-upgrade &&\
    apt-get -y install zip unzip

#
# easy-deposit
#

RUN cd /tmp &&\
    git clone https://github.com/DANS-KNAW/easy-deposit easy-deposit &&\
    cd /tmp/easy-deposit &&\
    # checkout version 1.0.2 (has no tag)
    git checkout 64378e6be6ff83994fd675eb61a6ea332b39ff67 &&\
    sed -i 's|https://easy.dans.knaw.nl/maven/|http://maven.dans.knaw.nl/|g' pom.xml &&\
    sed -i 's|DANS-EASY|FLAT|g' src/main/scala/nl/knaw/dans/api/sword2/StatementManagerImpl.scala &&\
    sed -i 's|DANS Default Data Collection|FLAT Deposit Bag Collection|g' src/main/scala/nl/knaw/dans/api/sword2/ServiceDocumentManagerImpl.scala

ADD sword/web.xml /tmp/easy-deposit/src/main/webapp/WEB-INF/web.xml

RUN cd /tmp/easy-deposit &&\
    mvn clean install &&\    
	cp target/easy-deposit.war /var/www/fedora/tomcat/webapps/easy-deposit.war &&\
	mkdir /var/www/fedora/tomcat/webapps/easy-deposit &&\
	cd /var/www/fedora/tomcat/webapps/easy-deposit/ &&\
	unzip ../easy-deposit.war &&\
	rm -r /tmp/easy-deposit
    
RUN mkdir -p /app/flat/deposit/sword/cfg &&\
    mkdir -p /app/flat/deposit/sword/tmp &&\
    mkdir -p /app/flat/deposit/bags
    
ADD sword/logback.xml /app/flat/deposit/sword/cfg/logback.xml
ADD sword/application.properties /app/flat/deposit/sword/cfg/application.properties
RUN sed -i "s|FLAT_HOST|${FLAT_HOST}|g" /app/flat/deposit/sword/cfg/application.properties &&\
    sed -i "s|FLAT_NAME|${FLAT_NAME}|g" /app/flat/deposit/sword/cfg/application.properties
    
ENV EASY_DEPOSIT_HOME="/app/flat/deposit/sword"
RUN if [ `grep 'environment=' /etc/supervisor/conf.d/supervisord-tomcat.conf` ]; \
      then sed -i 's|^environment=\(.*\)$|environment=\1,EASY_DEPOSIT_HOME="/app/flat/deposit/sword"|g' /etc/supervisor/conf.d/supervisord-tomcat.conf; \
      else echo '' >> /etc/supervisor/conf.d/supervisord-tomcat.conf; echo 'environment=EASY_DEPOSIT_HOME="/app/flat/deposit/sword"' >> /etc/supervisor/conf.d/supervisord-tomcat.conf; \
    fi

# Add proxy to Apache

RUN echo '# open up access to SWORD' >> /etc/apache2/apache2.conf &&\ 
    echo 'ProxyPass "/'${FLAT_NAME}'/easy-deposit" "http://localhost:8080/easy-deposit"' >> /etc/apache2/apache2.conf

#
# Add bagit
#

RUN cd /tmp &&\
    wget https://github.com/LibraryOfCongress/bagit-java/releases/download/v4.12.3/bagit-v4.12.3.zip &&\
    cd /app/ &&\
    unzip /tmp/bagit-v4.12.3.zip &&\
    ln -s bagit-v4.12.3 bagit &&\
    ln -s /app/bagit/bin/bagit /app/flat/bin/bag

#
# Add FLAT's own scripts and tools 
#

ADD flat/scripts/* /app/flat/bin/
RUN chmod +x /app/flat/bin/*.sh

#Clean up APT when done.
RUN apt-get clean &&\
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
