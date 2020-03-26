#BUILD_PUSH=hub,quay
FROM bigm/base-deb-tools
# see: https://github.com/Icinga/docker-icinga2

# install icinga2
RUN /xt/tools/_ppa_install ppa:formorer/icinga \
    apache2-utils php5-cli php5-mysql \
    icinga2-common icinga2 icinga2-ido-mysql \
    icinga2-classicui \
    icingaweb2 icingaweb2-module-monitoring icingaweb2-module-doc \
    nagios-plugins nagios-plugins-contrib nagios-plugins-extra

# create api certificates and users (will be overridden later)
RUN icinga2 api setup

# set icinga2 NodeName and create proper certificates required for the API
RUN sed -i -e 's/^.* NodeName = .*/const NodeName = "docker-icinga2"/gi' /etc/icinga2/constants.conf; \
 icinga2 pki new-cert --cn docker-icinga2 --key /etc/icinga2/pki/docker-icinga2.key --csr /etc/icinga2/pki/docker-icinga2.csr; \
 icinga2 pki sign-csr --csr /etc/icinga2/pki/docker-icinga2.csr --cert /etc/icinga2/pki/docker-icinga2.crt;

# configure PHP timezone
RUN sed -i 's/;date.timezone =/date.timezone = UTC/g' /etc/php5/apache2/php.ini

# enable features
RUN icinga2 feature enable command \
    && icinga2 feature enable livestatus \
    && usermod -a -G nagios www-data
## icinga2 feature enable compatlog ??? http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/icinga2-features#db-ido

RUN /xt/tools/_apt_install mysql-client python-pip python-xmpp python-dns

# create needed folders for later "icinga2 daemon" (based on /etc/init.d/icinga2 start)
ADD root/ /
RUN \
    mkdir -p /etc/icingaweb2/enabledModules \
    && ln -s /usr/share/icingaweb2/modules/monitoring /etc/icingaweb2/enabledModules/monitoring \
    && ln -s /usr/share/icingaweb2/modules/doc /etc/icingaweb2/enabledModules/doc \
    && ln -s /usr/share/icingaweb2/modules/iframe /etc/icingaweb2/enabledModules/iframe \
    && chown -R www-data:nagios /etc/icingaweb2/* \
    && mkdir -p /var/run/icinga2/cmd \
    && chown nagios:nagios /var/run/icinga2 \
    && chmod 0755 /var/run/icinga2 \
    && chown nagios:nagios /var/run/icinga2/cmd \
    && chmod 2710 /var/run/icinga2/cmd

#    && find /etc/icingaweb2 -type f -name "*.ini" -exec chmod 660 {} \; \
#    && find /etc/icingaweb2 -type d -exec chmod 2770 {} \; \

ADD startup/* /xt/startup/
ADD supervisor.d/* /etc/supervisord.d/

EXPOSE 80 443 5665

ENV ICINGAWEB_USER admin
ENV ICINGAWEB_REALM "Icinga Web 2"
#ENV ICINGAWEB_PASSWORD

#ENV ICINGAWEB_MYSQL_HOST localhost
ENV ICINGAWEB_MYSQL_USER icingaweb2
ENV ICINGAWEB_MYSQL_PASSWORD secret
ENV ICINGAWEB_MYSQL_DB icinga2
ENV ICINGAWEB_MYSQL_PORT ""
ENV ICINGAWEB_MYSQL_FROM "%"

#VOLUME ["/etc/icinga2", "/etc/icingaweb2", "/etc/icinga2-classicui", "/var/lib/icinga2", "/usr/share/icingaweb2"]

# folders under /xt/defaults will be populated in instance if they are empty
RUN mkdir -p /xt/defaults/etc \
    && cp -rp /etc/icinga2 /xt/defaults/etc/icinga2 \
    && cp -rp /etc/icingaweb2 /xt/defaults/etc/icingaweb2 \
    && cp -rp /etc/icinga2-classicui /xt/defaults/etc/icinga2-classicui

# syntax highlighting
#RUN echo '## Icinga 2' >> /etc/nanorc \
#    && echo 'include "/usr/share/icinga2-common/syntax/nano/icinga2.nanorc"' >> /etc/nanorc \
#    && mkdir /usr/share/vim/vimfiles/{syntax,ftdetect} \
#    && cp -a /usr/share/icinga2-common/syntax/vim/ftdetect/. /usr/share/vim/vimfiles/ftdetect/ \
#    && cp -a /usr/share/icinga2-common/syntax/vim/syntax/. /usr/share/vim/vimfiles/syntax/

# HipChat notification support
RUN pip install hipsaint

# TODO graphite support
