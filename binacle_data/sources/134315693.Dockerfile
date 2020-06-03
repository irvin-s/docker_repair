FROM irods/icat:4.1.3
MAINTAINER danb@renci.org

RUN apt-get update ; apt-get upgrade -y

#set up tomcat and apache
RUN apt-get -y install openjdk-7-jdk
RUN update-java-alternatives -s java-1.7.0-openjdk-amd64

RUN mkdir /usr/share/tomcat7
RUN mkdir /usr/share/tomcat7/common
RUN mkdir /usr/share/tomcat7/common/classes
RUN mkdir /usr/share/tomcat7/server
RUN mkdir /usr/share/tomcat7/server/classes
RUN mkdir /usr/share/tomcat7/shared
RUN mkdir /usr/share/tomcat7/shared/classes

RUN apt-get -y install tomcat7 apache2
ADD ./server.xml /etc/tomcat7/server.xml
RUN mkdir /etc/idrop-web
ADD ./idrop-web-config2.groovy /etc/idrop-web/idrop-web-config2.groovy
RUN rm -rf /var/lib/tomcat7/webapps/ROOT
RUN wget -O /var/lib/tomcat7/webapps/ROOT.war http://people.renci.org/~danb/FOR_DEMOS/iDrop-Web-2/idrop-web2.war
ADD ./ajp.apache /etc/apache2/sites-available/ajp.apache.conf
RUN a2enmod proxy_ajp
RUN a2dissite 000-default
RUN a2ensite ajp.apache

ADD ./bootstrap.sh /opt/irods/bootstrap.sh
ADD ./update-idw-config.sh /opt/irods/update-idw-config.sh
ADD ./tcstart.sh /opt/irods/tcstart.sh
RUN chmod a+x /opt/irods/*.sh

# set defaults for runtime variables that will be loaded into idrop-web-config2.groovy
ENV DOCKER_PORT80=8552
ENV DOCKER_HOSTNAME=localhost

EXPOSE 80
ENTRYPOINT [ "/opt/irods/bootstrap.sh" ]
