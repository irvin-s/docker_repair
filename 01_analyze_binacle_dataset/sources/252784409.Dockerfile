FROM bitswarm/apache-php-webapp:latest  
  
ENV SERVICE_ACCT="bitswarm" \  
SERVICE_ACCT_HOME="/opt/bitswarm" \  
SERVICE_ACCT_PASSWORD="CHANGE_ME" \  
SERVICE_ACCT_PRIVATE_KEY="CHANGE_ME" \  
SERVICE_ACCT_PUBLIC_KEY="CHANGE_ME" \  
SERVICE_ACCT_SUDO_ENABLED=0 \  
SERVICE_ACCT_SUDO_NO_PASSWD=1 \  
SSHD_ENABLED=1  
  
ENV DRUPAL_CORE_VERSION="8.0.0-beta9" \  
DRUSH_VERSION="7.0.0-rc1" \  
XDEBUG_ENABLED=0  
  
ENV GITHUB_OAUTH_TOKEN="CHANGE_ME"  
  
ENV MYSQL_HOST="mysql" \  
MYSQL_PORT="3306" \  
MYSQL_DATABASE="drupal" \  
MYSQL_USER="root" \  
MYSQL_PASSWORD="CHANGE_ME"  
  
COPY build /build  
  
RUN /build/scripts/prepare.sh && \  
/build/scripts/drush.sh && \  
/build/scripts/drupal.sh && \  
/build/scripts/cleanup.sh && \  
rm -rf /build  
  
VOLUME ["app"]  
  
EXPOSE 22 80  

