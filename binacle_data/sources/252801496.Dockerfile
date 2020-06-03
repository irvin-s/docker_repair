FROM easksd/tomcat7  
  
RUN groupadd -r kuali && useradd -r -g kuali kualiadm  
  
# copy in the tomcat utility scripts  
COPY bin /usr/local/bin/  
  
# set kfs web app directory owner and group  
RUN chmod +x /usr/local/bin/*  
  
# create some useful shorcut environment variables  
ENV TOMCAT_BASE_DIR=/var/lib/tomcat7  
ENV TOMCAT_SHARE_LIB=/usr/share/tomcat7/lib  
ENV TOMCAT_SHARE_BIN=/usr/share/tomcat7/bin  
ENV TOMCAT_WEBAPPS_DIR=$TOMCAT_BASE_DIR/webapps  
ENV TOMCAT_KFS_DIR=$TOMCAT_WEBAPPS_DIR/kfs  
ENV TOMCAT_KFS_WEBINF_DIR=$TOMCAT_KFS_DIR/WEB-INF  
ENV TRANSACTIONAL_DIRECTORY=/transactional  
ENV CONFIG_DIRECTORY=/configuration  
ENV LOGS_DIRECTORY=/logs  
ENV SECURITY_DIRECTORY=/security  
ENV TOMCAT_CONFIG_DIRECTORY=/configuration/tomcat-config  
ENV KFS_CONFIG_DIRECTORY=/configuration/kfs-config  
ENV TOMCAT_KFS_CORE_DIR=$TOMCAT_KFS_DIR/kfs-core-ua  
ENV UA_DB_CHANGELOGS_DIR=$TOMCAT_KFS_CORE_DIR/changelogs  
ENV UA_KFS_INSTITUTIONAL_CONFIG_DIR=$TOMCAT_KFS_DIR/kfs-core-ua  
  
# Update Environment target versions  
ENV KFS_VERSION_DEV=ua-release32-SNAPSHOT  
ENV KFS_REPOSITORY_DEV=snapshots  
  
ENV KFS_VERSION_TST=ua-release32-SNAPSHOT  
ENV KFS_REPOSITORY_TST=snapshots  
  
ENV KFS_VERSION_STG=ua-release31  
ENV KFS_REPOSITORY_STG=releases  
  
# copy in the new relic jar file  
COPY classes $TOMCAT_SHARE_LIB  
  
# setup log rotate  
RUN mv /etc/cron.daily/logrotate /etc/cron.hourly/logrotate  
ADD logrotate /etc/logrotate.d/tomcat7  
RUN chmod 644 /etc/logrotate.d/tomcat7  
  
ENTRYPOINT /usr/local/bin/tomcat-start  

