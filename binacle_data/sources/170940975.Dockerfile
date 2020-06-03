FROM        flat
MAINTAINER	Daniel von Rhein <daniel.vonrhein@mpi.nl>

# Add deposit module to installation
ADD flat_deposit /var/www/html/flat/sites/all/modules/custom/flat_deposit

# Create external data and metadata directories, error log directory
RUN mkdir -p /var/www/html/flat/sites/default/files/private/flat_deposit/data &&\
    mkdir -p /var/www/html/flat/sites/default/files/private/flat_deposit/metadata &&\
    mkdir -p /app/flat/backend/Ingest_service_log/app/flat/backend/Ingest_service_log &&\
    chown -R www-data:www-data /var/www/html/flat/sites/default/files/private/flat_deposit &&\
    chown -R www-data:www-data /app/flat/backend/Ingest_service_log

# add WYSIWYG editor
RUN cd /var/www/html/flat/sites/all/libraries/ &&\
    wget http://download.cksource.com/CKEditor/CKEditor/CKEditor%203.6.2/ckeditor_3.6.2.tar.gz &&\
    tar xzvf ckeditor_3.6.2.tar.gz

# change drupal default setting of database host from localhost to 127.0.0.1 as this is more reliable
RUN sed -e "s/'host' => 'localhost'/'host' => '127.0.0.1'/" /var/www/html/flat/sites/default/settings.php

# add extra modules
RUN cd /var/www/html/flat/ &&\
    export PGPASSWORD=fedora &&\
    service supervisor start &&\
    /wait-postgres.sh &&\
    supervisorctl start tomcat &&\
    /wait-tomcat.sh &&\
    /var/www/composer/vendor/drush/drush/drush dis toolbar -y &&\
    /var/www/composer/vendor/drush/drush/drush pmu toolbar -y &&\
    /var/www/composer/vendor/drush/drush/drush dl entity -y  &&\
    /var/www/composer/vendor/drush/drush/drush en entity -y  &&\
    /var/www/composer/vendor/drush/drush/drush dl wysiwyg -y  &&\
    /var/www/composer/vendor/drush/drush/drush en wysiwyg -y  &&\
    /var/www/composer/vendor/drush/drush/drush dl imce -y  &&\
    /var/www/composer/vendor/drush/drush/drush en imce -y  &&\
    /var/www/composer/vendor/drush/drush/drush dl imce_wysiwyg -y  &&\
    /var/www/composer/vendor/drush/drush/drush en imce_wysiwyg -y   &&\
    /var/www/composer/vendor/drush/drush/drush dl httprl -y  &&\
    /var/www/composer/vendor/drush/drush/drush en httprl -y  &&\
    /var/www/composer/vendor/drush/drush/drush dl -y filefield_paths  &&\
    /var/www/composer/vendor/drush/drush/drush en -y filefield_paths  &&\
    /var/www/composer/vendor/drush/drush/drush -y dl content_access  &&\
    /var/www/composer/vendor/drush/drush/drush -y en content_access  &&\
    /var/www/composer/vendor/drush/drush/drush -y dl job_scheduler &&\
    /var/www/composer/vendor/drush/drush/drush -y dl token &&\
    /var/www/composer/vendor/drush/drush/drush -y cache-clear all &&\
    /var/www/composer/vendor/drush/drush/drush -y dl feeds &&\
    /var/www/composer/vendor/drush/drush/drush -y en feeds &&\
    /var/www/composer/vendor/drush/drush/drush -y dl views  &&\
    /var/www/composer/vendor/drush/drush/drush -y en views  &&\
    /var/www/composer/vendor/drush/drush/drush -y en views_ui &&\
    /var/www/composer/vendor/drush/drush/drush -y dl views_autorefresh &&\
    /var/www/composer/vendor/drush/drush/drush -y en views_autorefresh &&\
    # /var/www/composer/vendor/drush/drush/drush en flat_deposit -y &&\
    # enable module manually, otherwise docker build fails due to directories not being present
    supervisorctl stop all &&\
    service supervisor stop &&\
    /wait-sergtsop.sh

# add module configuration
ENV PGPASSWORD=fedora
COPY drupal/wysiwyg.sql /tmp/wysiwyg.sql
COPY drupal/settings_imce.php /tmp/settings_imce.php

RUN cd /var/www/html/flat/ &&\
    export PGPASSWORD=fedora &&\
    service supervisor start &&\
    /wait-postgres.sh &&\
    supervisorctl start tomcat &&\
    /wait-tomcat.sh &&\
    cd /var/www/html/flat/ &&\
    /var/www/composer/vendor/drush/drush/drush sql-query "$(cat /tmp/wysiwyg.sql)" -y &&\
    /var/www/composer/vendor/drush/drush/drush php-script settings_imce --script-path=/tmp &&\
    /var/www/composer/vendor/drush/drush/drush dl imce_mkdir -y &&\
    /var/www/composer/vendor/drush/drush/drush en imce_mkdir -y &&\
    supervisorctl stop all &&\
    service supervisor stop &&\
    sleep 1

RUN apt-get update &&\
    apt-get install -y php-zip php-mbstring

# add owncloud to version
RUN wget -nv https://download.owncloud.org/download/repositories/stable/Ubuntu_16.04/Release.key -O Release.key &&\
    apt-key add - < Release.key

RUN sh -c "echo 'deb http://download.owncloud.org/download/repositories/stable/Ubuntu_16.04/ /' >> /etc/apt/sources.list.d/owncloud.list" &&\
    apt-get update &&\
    apt-get install -y --allow-unauthenticated owncloud-files

RUN /etc/init.d/postgresql start &&\
    su -c "createdb -O fedora owncloud" postgres &&\
    /etc/init.d/postgresql stop

RUN apt-get update &&\
    apt-get install sudo

RUN /etc/init.d/postgresql start &&\
    cd /var/www/owncloud &&\
        sudo -u www-data php occ maintenance:install --database "pgsql" --database-name "owncloud" --database-user "fedora" --database-pass "fedora" --admin-user "admin" --admin-pass "admin"

COPY owncloud/addTrusted.php /tmp/addTrusted.php

RUN mv /var/www/owncloud/config/config.php /var/www/owncloud/config/config.backup &&\
    printf "<?php\n\$CONFIG = $(php /tmp/addTrusted.php) ;" >/var/www/owncloud/config/config.php &&\
    chown www-data:www-data /var/www/owncloud/config/config.php

COPY owncloud/changeRights.sh /tmp/changeRights.sh
RUN /tmp/changeRights.sh

#RUN /etc/init.d/postgresql start &&\
#   /var/www/fedora/tomcat/bin/startup.sh &&\
#   sleep 10 &&\
#   cd /var/www/owncloud/ &&\
#   sudo -u www-data php occ app:enable files_external


#Add bagit to image
RUN cd /app/flat &&\
    git clone https://github.com/LibraryOfCongress/bagit-java.git bagit &&\
    cd bagit &&\
    git checkout bagit-4.9.0 &&\
    mvn -Dmaven.test.skip=true clean install &&\
    cp target/bagit-4.9.0-bin.zip /usr/local/bin/ &&\
    cd /usr/local/bin/ &&\
    unzip bagit-4.9.0-bin.zip &&\
    PATH=/usr/local/bin/bagit-4.9.0/bin:$PATH &&\
    chmod 777 /usr/local/bin/bagit-4.9.0/bin/bag &&\
    apt-get -y install zip unzip


#Add accessible freeze directory to server
RUN mkdir -p /app/flat/backend &&\
    chown www-data:www-data /app/flat/backend

#Add test dataset to repository
COPY Testset /app/flat/Testset
RUN chown -R www-data:www-data /app/flat/Testset


#Clean up when done.
RUN apt-get clean &&\
  rm -rf /tmp/* /var/tmp/*

# Comment this line of code if you don't have a local installation of the deposit UI that is mounted as /var/www/html/drupal/sites/all/modules/custom/flat_deposit_ui
#RUN rm -rf /var/www/html/flat/sites/all/modules/custom/flat_deposit_ui
