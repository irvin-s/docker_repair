FROM bitswarm/apache-php:latest  
  
ENV SERVICE_ACCT="bitswarm" \  
SERVICE_ACCT_HOME="/opt/bitswarm" \  
SERVICE_ACCT_PASSWORD="CHANGE_ME" \  
SERVICE_ACCT_PRIVATE_KEY="CHANGE_ME" \  
SERVICE_ACCT_PUBLIC_KEY="CHANGE_ME" \  
SERVICE_ACCT_SUDO_ENABLED=1 \  
SERVICE_ACCT_SUDO_NO_PASSWD=1 \  
SSHD_ENABLED=0  
  
ENV COMPOSER_HOME="/usr/share/composer" \  
DRUSH_VERSION="6.6.0" \  
XDEBUG_ENABLED=0  
  
ENV GITHUB_OAUTH_TOKEN="CHANGE_ME"  
  
COPY build /build  
  
RUN /build/scripts/prepare.sh && \  
/build/scripts/utilities.sh && \  
/build/scripts/composer.sh && \  
/build/scripts/drush.sh && \  
/build/scripts/service-acct.sh && \  
/build/scripts/sshd.sh && \  
cp -Rfv /build/my_init.d /etc/ && \  
chmod -R 700 /etc/my_init.d && \  
/build/scripts/cleanup.sh && \  
rm -rf /build  
  
VOLUME ["app"]  
  
EXPOSE 22 80  

