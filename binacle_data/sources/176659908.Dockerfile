#------------------------------------------------------------------------------
# Dockerized "fat" machine container for deploying apache
# This container image is based on the phusion/baseimage 
# (https://github.com/phusion/baseimage-docker)  a multiprocess 
# container with various components such as cron, ssh, syslog, logrotate
# more akin to a full machine. 
# Tutum apache-php (https://github.com/tutumcloud/tutum-docker-php) is rebuilt
# ontop of phusion/baseimage:0.9.15
#------------------------------------------------------------------------------

# BUILD:
# $ cd web/tutum/tutum-docker-php
# $ docker build --tag="afolarin/cron-apache-php" .

# USAGE:
# docker run -d --publish="80:80" afolarin/cron-apache-php



#need local cron for redcap so rebasing on phusions fat container image
FROM phusion/baseimage:0.9.15
MAINTAINER Amos Folarin <amosfolarin@gmail.com>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
#??# RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


###############################################################################
#----------------------- start tutum/apache-php layers -----------------------#
###############################################################################
# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
	    apt-get -yq install \
	    curl \
	    apache2 \
	    libapache2-mod-php5 \
	    php5-mysql \
	    php5-gd \
	    php5-curl \
	    php-pear \
	    php-apc && \
	    rm -rf /var/lib/apt/lists/*

RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

###############################################################################
# my_runit: Startup scripts in /etc/my_init.d are run at container start
###############################################################################
# 


###############################################################################
# my_runit: Daemonised processes /etc/service/<name>/run
###############################################################################
# Runtime sensitive information provided as [--env, --env-file] environment variables,
# which are processed by parse_redcap_config.sh into the database.php file
# control is then passed to the run.sh script
COPY run /etc/service/apache/
RUN chmod 755 /etc/service/apache/run



# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

#Sample application (prints out linked containers info, so commenting out)
# but if for any reason you require this, uncomment it and rebuild
ADD sample/ /app

EXPOSE 80
WORKDIR /app


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


