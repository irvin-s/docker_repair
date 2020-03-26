############################################################
# Dockerfile to run Apache usergrid_
# Based on Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM ubuntu

MAINTAINER Gabor Wnuk <gabor.wnuk@me.com>

ENV TOMCAT_CONFIGURATION_FLAG /usergrid/.tomcat_admin_created

RUN mkdir /usergrid
WORKDIR /usergrid

RUN apt-get update ; apt-get install -y wget curl pwgen openjdk-7-jdk tomcat7

#
# Configure basic stuff, nothing important.
#
ADD create_tomcat_admin_user.sh /usergrid/create_tomcat_admin_user.sh
ADD run.sh /usergrid/run.sh
ADD usergrid-custom.properties /usr/share/tomcat7/lib/usergrid-custom.properties
RUN chmod +x /usergrid/*.sh
RUN ln -s /etc/tomcat7/ /usr/share/tomcat7/conf
 
#
# Just to suppress tomcat warnings.
#
RUN mkdir -p /usr/share/tomcat7/common/classes; \
mkdir -p /usr/share/tomcat7/server/classes; \
mkdir -p /usr/share/tomcat7/shared/classes; \
mkdir -p /usr/share/tomcat7/webapps; \
mkdir -p /usr/share/tomcat7/temp

#
# Deploy WAR
#
ADD ROOT.war /usr/share/tomcat7/webapps/ROOT.war

RUN ln -s /usr/share/tomcat7/webapps/ /etc/tomcat7/webapps

RUN curl -sLo /usr/local/bin/ep https://github.com/kreuzwerker/envplate/releases/download/v0.0.5/ep-linux && chmod +x /usr/local/bin/ep

#
# Port to expose (default for tomcat: 8080)
#
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/ep", "/usr/share/tomcat7/lib/usergrid-custom.properties", "--", "./run.sh"]
