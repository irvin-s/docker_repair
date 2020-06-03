#
# Build an Apache TomEE container and deploy the WAR-Archives
# 
# ##################### INFOS ######################
#   - Config path: /usr/local/tomee/conf
#   - Webapp path: /usr/local/tomee/webapps
#   - User for the Tomcat Manager Application: tomee:tomee 
#   
#   - ROOT App:            /admin                                       e.g. http://localhost:8080/admin
#   - Quickstart App:      /angular2-qickstart-javaee7-application      e.g. http://localhost:8080/angular2-qickstart-javaee7-application
#   - Quickstart Angular:  /angular2-qickstart-javaee7-client-web       e.g. http://localhost:8080/angular2-qickstart-javaee7-client-web
# ##################### INFOS ######################
#
#
# ##################### DOCKER #####################
# BUILD
# docker build -t angular2/javaee7-quickstart:1.0.0 .
#
# RUN (add -d parameter to start a container in detached mode)
# docker run -P -it --rm -p 8080:8080 --name angular2-javaee7-quickstart angular2/javaee7-quickstart:1.0.0
#
# STOP
# docker stop angular2-javaee7-quickstart
#
# REMOVE CONTAINER AND IMAGE
# docker rm -f angular2-javaee7-quickstart ; docker rmi -f angular2/javaee7-quickstart:1.0.0
#
# LOGIN INTO CONTAINER
# docker exec -i -t angular2-javaee7-quickstart /bin/bash
#
# COPY FILE FROM CONTAINER TO HOST
# docker cp angular2-javaee7-quickstart:/usr/local/tomee/conf/web.xml ./web.xml
#
# ##################### DOCKER #####################
#
#

# build file based on TomEE 7.0.1 Plume
FROM tomee:8-jdk-7.0.1-plume
MAINTAINER "Markus Eschenbach <mail@blogging-it.com>"


# ************* MODIFY CONTAINER FILES *************

# rename ROOT application folder to admin
RUN mv /usr/local/tomee/webapps/ROOT /usr/local/tomee/webapps/admin

# create new ROOT application folder and index.jsp welcome file
RUN mkdir /usr/local/tomee/webapps/ROOT && echo "<html><head></head><body>It works!</body></html>" >> /usr/local/tomee/webapps/ROOT/index.jsp

# add admin user tomee:tomee
RUN sed -i '/<\/tomcat-users>/d' /usr/local/tomee/conf/tomcat-users.xml
RUN echo "<role rolename=\"admin-gui\"/> \
<role rolename=\"tomee-admin\"/> \
<role rolename=\"manager-gui\"/> \
<user username=\"tomee\" password=\"tomee\" roles=\"tomee-admin,manager-gui,admin-gui,manager-script\" /> \
</tomcat-users>" >> /usr/local/tomee/conf/tomcat-users.xml


# **************** INSTALL TOOLS *****************

# Avoid warnings during installsets
# variable only live during the build process
ARG DEBIAN_FRONTEND=noninteractive

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager. 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
       apt-utils \ 
       && rm -rf /var/lib/apt/lists/*

# make sure the package repository is up to date and install tools like nano etc.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
       nano


# *************** ADD APPLICATIONS ***************

ADD module-application/target/angular2-qickstart-javaee7-application.war /usr/local/tomee/webapps/angular2-qickstart-javaee7-application.war
ADD module-client-web/target/angular2-qickstart-javaee7-client-web.war /usr/local/tomee/webapps/angular2-qickstart-javaee7-client-web.war


# ******************** EXPOSE ********************

EXPOSE 8080



