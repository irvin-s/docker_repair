#
# Docker image to build a SonarQube platform container for 
# continuous inspection of code quality based on OpenJDK 8 image.
# 
# ######################## INFOS ##########################
#  Image based on https://hub.docker.com/_/openjdk
#
#   - Expose 
#         9000 Sonar Web App HTTP
#         9092 H2 Database 
#
#   - Data path:    /opt/sonarqube/data
#   - Plugins path: /opt/sonarqube/extensions/plugins
#
#   - Web Application
#         User:    admin:admin 
#         Path:    /    e.g. http://localhost:9000
# ######################## INFOS ##########################
#
#
# ######################## DOCKER #########################
# BUILD
# docker build -t blogging-it/internal-sonarqube:1.0.0 .
#
# RUN (add -d parameter to start a container in detached mode)
# docker run -P -it --rm -p 9000:9000 -p 9092:9092 --name internal-sonarqube blogging-it/internal-sonarqube:1.0.0
#
# STOP
# docker stop internal-sonarqube
#
# REMOVE CONTAINER AND IMAGE
# docker rm -f internal-sonarqube ; docker rmi -f blogging-it/internal-sonarqube:1.0.0
#
# LOGIN INTO CONTAINER
# docker exec -i -t internal-sonarqube /bin/bash
#
# COPY FILE FROM CONTAINER TO HOST
# docker cp internal-sonarqube:/opt/sonarqube/data ./data
#
# CHECK CONTAINER LOGS
# docker logs internal-sonarqube
#
# ######################## DOCKER #########################
#

# ######################## BASE ###########################

FROM openjdk:8
MAINTAINER "Markus Eschenbach <mail@blogging-it.com>"

# ***************** ENVIRONMENT VARIABLES *****************

ENV SQ_HOME=/opt/sonarqube \
    SQ_VERSION=6.3 \
    SQ_WEB_JVM_OPTS= \
    SQ_LOG_CONSOLE=true \
    SQ_DOWNLOAD_URL=https://sonarsource.bintray.com/Distribution/sonarqube \
    SQ_TS_PLUGIN_VERSION=1.1.0 \
    SQ_TS_PLUGIN_URL=https://github.com/Pablissimo/SonarTsPlugin/releases/download/v

ENV SQ_TS_PLUGIN_NAME=sonar-typescript-plugin-$SQ_TS_PLUGIN_VERSION.jar
    
# Database configuration
ENV SQ_JDBC_USERNAME=sonar \
    SQ_JDBC_PASSWORD=sonar \
    SQ_JDBC_PORT=9092 \
    SQ_JDBC_URL=jdbc:h2:tcp://localhost:9092/sonar
#   SQ_JDBC_URL=jdbc:postgresql://localhost/sonar

# ************ DOWNLOAD AND INSTALL SONARQUBE *************

RUN set -x \

    # pub   2048R/D26468DE 2015-05-25
    #       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
    # uid   sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
    # sub   2048R/06855C1D 2015-05-25
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \

    && cd /opt \
    && curl -o sonarqube.zip -fSL $SQ_DOWNLOAD_URL/sonarqube-$SQ_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL $SQ_DOWNLOAD_URL/sonarqube-$SQ_VERSION.zip.asc \
    && gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
    && unzip sonarqube.zip \
    && mv sonarqube-$SQ_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SQ_HOME/bin/*


# *************** INSTALL SONARQUBE PLUGINS ***************

# SonarTsPlugin - https://github.com/Pablissimo/SonarTsPlugin
RUN set -x \
    && mkdir -p $SQ_HOME/extensions/plugins \
    && cd $SQ_HOME/extensions/plugins \
    && curl -o $SQ_TS_PLUGIN_NAME -fSLk $SQ_TS_PLUGIN_URL$SQ_TS_PLUGIN_VERSION/$SQ_TS_PLUGIN_NAME



# ********************* EXPOSE PORTS *********************

# Sonar Web App HTTP
EXPOSE 9000

# H2 Database 
EXPOSE 9092

# *********************** VOLUMES ************************

VOLUME ["$SQ_HOME/data", "$SQ_HOME/extensions"]

# *********************** RUNSCRIPT **********************

WORKDIR $SQ_HOME
COPY run.sh $SQ_HOME/bin/

RUN set -x \
    && chmod +x $SQ_HOME/bin/run.sh

# ********************** ENTRYPOINT **********************

ENTRYPOINT ["./bin/run.sh"]