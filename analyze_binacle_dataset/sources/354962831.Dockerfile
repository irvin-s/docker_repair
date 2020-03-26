# This content is part of the native-dockerfiles project and released under the MIT License (see attached LICENSE file)
# (c) 2015-2017 Thomas Mayer
# Get the latest version at https://github.com/thomaszbz/native-dockerfiles-typo3

FROM debian:jessie
MAINTAINER Thomas Mayer "thomas.mayer@2bis10.de"

LABEL Description="Provides basic test environment for TYPO3 CMS developers"

# IMPORTANT: replace "1000" with your UID/GID (must correspond to file share's user).
# Your UID/GID will render the webadmin to have ownership of the files in the context of the docker guest system.

ENV SHARE_USER=webadmin
ENV SHARE_UID=1000
ENV SHARE_GROUP=webadmin
ENV SHARE_GID=1000

# Add webadmin user and webadmin's home directory
#
# webadmin is owner of files in the shares in the context of the docker guest. When file permissions are set right
#    - webadmin has write access (by ownership)
#    - www-data only has read access to most files (by group)
# If webadmin needs write access to files or directories, you need to give write permissions to the
# group of webadmin (which is actually your personal group on the host system)
# That way, you can simulate permissions for www-data when using a webadmin-like non-root-user on a production system.

RUN groupadd --gid $SHARE_GID $SHARE_GROUP
RUN adduser --system --quiet --disabled-password --gid $SHARE_GID --uid $SHARE_UID $SHARE_USER
RUN mkdir -p /var/webadmin
RUN chown $SHARE_USER:$SHARE_GROUP /var/webadmin

# create DocumentRoot folder and folder for TYPO3 extensions

RUN mkdir -p /var/www/typo3/typo3conf/ext

# Basic settings for TYPO3's install tool in file AdditionalConfiguration.php
# If you want to edit these values values you need to remove this file first (or parts of it).

RUN echo "<?php\n\$GLOBALS['TYPO3_CONF_VARS']['SYS']['systemLocale']='en_US.UTF-8';\
\n\$GLOBALS['TYPO3_CONF_VARS']['GFX']['im_version_5']='gm';\
\n" > /var/www/typo3/typo3conf/AdditionalConfiguration.php

# Create TYPO3's symlink structure. These are dead links until we mount the file shares (which will be done
# after the provision has completed).

RUN cd /var/www/typo3 && \
ln -s ../../webadmin/typo3_src typo3_src && \
ln -s ../../webadmin/typo3_src/_.htaccess .htaccess && \
ln -s typo3_src/index.php index.php && \
ln -s typo3_src/typo3 typo3

# Give webadmin read and write access to DocumentRoot directory structure
# This has no effect to files in the file share which are not mounted at this time.

RUN chown -R webadmin:webadmin /var/www/typo3

# Make sure we are not asked for a MySQL password while we provision

RUN echo "mysql-server-5.5 mysql-server/root_password password {{password}}" | debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password_again password {{password}}" | debconf-set-selections

# Update apt sources and installed packages

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes apt-utils && \
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --force-yes

# Create and configure locales

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes locales
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_TYPE=en_US.UTF-8

RUN echo 'en_US.UTF-8' > /etc/default/locale && \
echo 'LANGUAGE=en_US.UTF-8' >> /etc/environment && \
echo 'LC_ALL=en_US.UTF-8' >> /etc/environment && \
echo 'LANG=en_US.UTF-8' >> /etc/environment && \
echo 'LC_TYPE=en_US.UTF-8' >> /etc/environment && \
sed --in-place 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && \
locale-gen && \
update-locale

# Install basic packages every GNU/Linux developer system should have

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wget curl net-tools vim git man-db inotify-tools locate

# Install MySQL database packages

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mysql-server mysql-client

# Install MySQL or MariaDB
RUN { \
        echo "mysql-server-5.5 mysql-server/root_password password {{password}}"; \
        echo "mysql-server-5.5 mysql-server/root_password_again password {{password}}"; \
    } | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mysql-server mysql-client && \
    service mysql start && \
    { \
        echo "GRANT ALL PRIVILEGES ON  *.* to 'admin'@'localhost' IDENTIFIED BY '{{password}}' WITH GRANT OPTION;"; \
        echo "FLUSH PRIVILEGES;"; \
    } | mysql -p{{password}}

# Install Apache webserver packages

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes apache2 apache2-utils

# Install PHP packages

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes php5 php5-cli libapache2-mod-php5 php5-mysqlnd php5-curl php5-gd php5-apcu
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes graphicsmagick

# Configure Apache default vHost

#   DocumentRoot /var/www/typo3

RUN sed --in-place 's!/var/www/html!/var/www/typo3\
\n\t<Directory /var/www/typo3>\
\n\t\tAllowOverride AuthConfig Indexes FileInfo Options=MultiViews,Indexes\
\n\t\t<IfModule mod_php5.c>\
\n\t\t\tphp_admin_value upload_max_filesize "10M"\
\n\t\t\tphp_admin_value post_max_size "15M"\
\n\t\t\tphp_admin_value max_execution_time "240"\
\n\t\t\tphp_admin_value max_input_vars "1500"\
\n\t\t\tphp_admin_value always_populate_raw_post_data "-1"\
\n\t\t</IfModule>\
\n\t</Directory>\
!g' /etc/apache2/sites-available/000-default.conf

RUN chgrp -R www-data /var/www/typo3 && \
chmod 775 /var/www/typo3 && \
chgrp -R www-data /var/www/typo3/typo3conf && \
chmod -R 775 /var/www/typo3/typo3conf

# apcu cache gets 128MB of memory (default was 32 MB)

RUN echo "apc.shm_size=128M" > /etc/php5/apache2/conf.d/20-apcu-custom.ini

# Enable PHP modules

RUN a2enmod rewrite
RUN a2enmod expires

# Restart apache to let changes take effect and to test if it still runs (we don't want to roll out a broken image)

RUN service apache2 restart

# Let www-data eventually read/write files from the shares via group permissions

RUN gpasswd -a www-data webadmin

# Let webadmin eventually read/write files created by www-data via group permissions

RUN gpasswd -a webadmin www-data

# Install composer globally

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
