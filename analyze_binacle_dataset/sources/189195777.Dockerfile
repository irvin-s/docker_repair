FROM bigm/base-deb
# https://github.com/LyleScott/docker-nagios4/blob/master/Dockerfile
# https://github.com/opinkerfi/adagios/wiki/Install-guide
# alternative: http://www.rohit.io/blog/rip-nagios-hello-docker-shinken.html
# followed some instructions from http://cytheric.net/ref/adagios.html

RUN /xt/tools/_apt_install nagios3 pnp4nagios git libapache2-mod-wsgi check-mk-livestatus python-pip \
  python-django python-simplejson libgmp-dev python-dev python-paramiko php5-cli

# pynag adagios
RUN pip install pynag adagios
# django==1.4.15 ??? https://github.com/opinkerfi/adagios/pull/431
# pip install --install-option="--prefix=/opt/adagios" django==1.4.15 pynag adagios

# If you plan on using the built-in status view in adagios you need these:
RUN pynag config --append "broker_module=/usr/lib/check_mk/livestatus.o /var/lib/nagios3/rw/livestatus"

# New objects created with adagios go here, make sure nagios is reading that directory
RUN mkdir -p /etc/nagios3/adagios \
  && pynag config --append "cfg_dir=/etc/nagios3/adagios"

# Make sure nagios group will always have write access to the configuration files:
RUN chown -R nagios /etc/nagios3 /etc/adagios

# Install pnp4nagios and get graphs working
RUN pynag config --set "process_performance_data=1" \
  && pynag config --append "broker_module=/usr/lib/pnp4nagios/npcdmod.o config_file=/etc/pnp4nagios/npcd.cfg" \
  && usermod -G www-data nagios \
  && sed -i 's/RUN.*/RUN="yes"/' /etc/default/npcd

# adagios for Debian
RUN sed -i 's|/etc/nagios/nagios.cfg|/etc/nagios3/nagios.cfg|;' /etc/adagios/adagios.conf \
  && sed -i 's|sudo /etc/init.d/nagios|sudo /etc/init.d/nagios3|;' /etc/adagios/adagios.conf \
  && sed -i 's|nagios_url = "/nagios"|nagios_url = "/nagios3"|;' /etc/adagios/adagios.conf \
  && sed -i 's|destination_directory.*|destination_directory = "/etc/nagios3/adagios/"|;' /etc/adagios/adagios.conf \
  && sed -i 's|nagios_binary.*|nagios_binary = "/usr/sbin/nagios3"|;' /etc/adagios/adagios.conf \
  && sed -i 's|pnp_filepath.*|pnp_filepath = "/usr/share/pnp4nagios/html/index.php"|;' /etc/adagios/adagios.conf \
  && sed -i 's|$conf\[\x27livestatus_socket\x27\].*|$conf[\x27livestatus_socket\x27] = "unix:/var/lib/nagios3/rw/livestatus";|;' /etc/pnp4nagios/config.php

RUN mkdir -p /var/lib/adagios && chown -R nagios:www-data /var/lib/adagios

#TODO  && sed -i 's|nagios_init_script=.*|nagios_init_script = "supervisorctl RESTART"|;' /etc/adagios/adagios.conf \

RUN htpasswd -c -b -s /etc/nagios3/htpasswd.users admin admin \
  && chown -R nagios.nagios /etc/nagios3/htpasswd.users

## Create git repo which adagios uses for version control
RUN cd /etc/nagios3/ \
  && git init \
  && git config --global user.email "you@example.com" \
  && git config --global user.name "Your Name" \
  && git add . \
  && git commit -a -m "Initial commit"

# configure services
ADD supervisor/* /etc/supervisord.d/
ADD sites/* /etc/apache2/sites-enabled/

## this config will be used to initialize if empty config is mounted
RUN mv /etc/nagios3 /etc/nagios3_orig
ADD startup/* /prj/startup/
