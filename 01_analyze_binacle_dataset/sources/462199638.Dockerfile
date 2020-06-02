#
# Copyright © 2017 Logistimo.
#
# This file is part of Logistimo.
#
# Logistimo software is a mobile & web platform for supply chain management and remote temperature monitoring in
# low-resource settings, made available under the terms of the GNU Affero General Public License (AGPL).
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General
# Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License
# for more details.
# 
# You should have received a copy of the GNU Affero General Public License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
# You can be released from the requirements of the license by purchasing a commercial license. To know more about
# the commercial license, please contact us at opensource@logistimo.com
#


FROM tomcat:7-jre8
MAINTAINER dockers@logistimo.com

ARG warname

ENV TOMCAT_HOME /usr/local/tomcat

RUN rm -rf $TOMCAT_HOME/webapps/* \
	&& apt-get update \
        && apt-get install -y gettext-base

ADD modules/web/target/$warname $TOMCAT_HOME/webapps/

RUN  wget -P $TOMCAT_HOME/lib/ http://central.maven.org/maven2/org/apache/commons/commons-pool2/2.2/commons-pool2-2.2.jar \
        && wget -P $TOMCAT_HOME/lib/ http://central.maven.org/maven2/redis/clients/jedis/2.5.2/jedis-2.5.2.jar \
        && wget -P $TOMCAT_HOME/lib/ http://central.maven.org/maven2/com/bluejeans/tomcat-redis-session-manager/2.0.0/tomcat-redis-session-manager-2.0.0.jar

ADD dockerfiles/context.xml $TOMCAT_HOME/conf/

RUN unzip -o $TOMCAT_HOME/webapps/$warname \
        -d $TOMCAT_HOME/webapps/ROOT/ \
        && rm -rf $TOMCAT_HOME/webapps/$warname

ENV MYSQL_HOST_URL="jdbc:mariadb://localhost/logistimo?useUnicode=true&amp;characterEncoding=UTF-8" \
        MYSQL_RO_HOST_URL="jdbc:mariadb://localhost/logistimo?useUnicode=true&amp;characterEncoding=UTF-8" \
        MYSQL_USER=logistimo \
        MYSQL_PASS=logistimo \
        MYSQL_DATABASE=logistimo \
        REDIS_HOST=localhost \
        SENTINEL_HOST= \
        SENTINEL_MASTER= \
        HADOOP_HOST=localhost \
        MEDIA_HOST_URL=http://localhost:50070/webhdfs/v1 \
        ZKR_HOST=localhost:2181 \
        LOGI_HOST=localhost \
        ACTIVEMQ_HOST=tcp://localhost:61616 \
        TASK_SERVER=true \
        TASK_URL=http://localhost:8080 \
        TASK_QUEUE_TYPE=simple \
        TASK_EXPORT=true \
        EMAIL_HOST=localhost \
        EMAIL_PORT=25 \
        EMAIL_FROMADDRESS=service@logistimo.com \
        EMAIL_FROMNAME=Logistimo\ Service \
        TASK_PORT=8080 \
        CALLISTO_HOST_URL=http://localhost:8090 \
        LOCAL_ENV=true \
        LOC_URL=http://localhost:9090 \
        APPROVAL_URL=http://localhost:6400 \
        STOCKREBALANCING_URL=http://localhost:8700 \
        COLLABORATION_URL=http://localhost:9070/v1/collaboration/likes \
        CON_MAX_IDLE=50 \
        CON_MIX_IDLE=20 \
        CON_MAX_ACTIVE=150 \
        CON_MAX_WAIT=1000 \
        CACHE_TYPE=none \
        STATUS_FILE= \
        JMX_AGENT_PORT=8088 \
        ORIGINS=*.logistimo.com,localhost \
        MAPI_URL=http://localhost:8080 \
        CAPTCHA_ENABLE=true \
        GOOGLE_ANALYTICS_CLIENT_ID= \
        JAVA_OPTS="-Xms1024m -Xmx1024m -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap" \
        EVENTSUMMARYSERVICE_URL=http://logi-es:9010/v1/event-summaries

ENV WEB_APP_VER $WEB_APP_VER

RUN cd $TOMCAT_HOME && wget http://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.7/jmx_prometheus_javaagent-0.7.jar

ADD dockerfiles/jmx_exporter.json $TOMCAT_HOME/jmx_exporter.json

COPY dockerfiles/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 8080-8090

CMD ["/docker-entrypoint.sh"]
