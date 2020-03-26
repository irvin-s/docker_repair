FROM debian:stretch

MAINTAINER Jeyser-CRM <dsi@n7consulting.fr>

# non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN echo mail > /etc/hostname \
    && chown root:root /etc/hosts

# Install Postfix. Use syslog-ng to get Postfix logs
RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt \
    && echo "postfix postfix/mailname string mail.example.com" >> preseed.txt \
    && debconf-set-selections preseed.txt \
    && apt-get update \
    && apt-get install -y postfix syslog-ng syslog-ng-core --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && postconf -e myhostname="mail.example.com" \
    && postconf -e mydestination="mail.example.com, example.com, localhost.localdomain, localhost" \
    && postconf -e mail_spool_directory="/var/spool/mail/" \
    && postconf -e mailbox_command="" \
    && postconf -e mynetworks="127.0.0.0/8 172.16.0.0/12 [::1]/128 [fe80::]/64" \
    && postconf -e smtpd_recipient_restrictions="permit_sasl_authenticated permit_mynetworks defer_unauth_destination" \
    && postconf -e smtpd_relay_restrictions="permit_sasl_authenticated permit_mynetworks defer_unauth_destination"

# Add a local user to receive mail at someone@example.com, with a delivery directory
# (for the Mailbox format).
RUN useradd -s /bin/bash someone \
    && mkdir /var/spool/mail/someone \
    && chown someone:mail /var/spool/mail/someone \
    && chown root:root /etc/aliases \
    && newaliases

# Handle syslog
# Replace the system() source because inside Docker we can't access /proc/kmsg.
# https://groups.google.com/forum/#!topic/docker-user/446yoB0Vx6w
RUN sed -i -E 's/^(\s*)system\(\);/\1unix-stream("\/dev\/log");/' /etc/syslog-ng/syslog-ng.conf \
# Uncomment 'SYSLOGNG_OPTS="--no-caps"' to avoid the following warning:
# syslog-ng: Error setting capabilities, capability management disabled; error='Operation not permitted'
# http://serverfault.com/questions/524518/error-setting-capabilities-capability-management-disabled#
   && sed -i 's/^#\(SYSLOGNG_OPTS="--no-caps"\)/\1/g' /etc/default/syslog-ng

#To workaround some extremely strange tail -f behavior (which says "has been replaced with a remote file. giving up on this name"), create and truncate log file on start up
CMD ["/bin/sh", "-c", "service syslog-ng start; service postfix start; umask 0 && truncate -s0 /var/log/mail.log; tail -n0 -F /var/log/mail.log"]

# build docker image and run docker container by
# docker build -t postfix .
# to allow mail/sendmail command work locally
# mkdir -p /var/spool/postfix; chmod 0777 /var/spool/postfix; docker run -p 25:25 -v /var/spool/postfix:/var/spool/postfix postfix

# test sending mail by command of sendmail by following command
# /usr/sbin/sendmail teraproc.john@gmail.com

# test sending mail by telnet with smtp protocol by http://stackoverflow.com/questions/4798772/postfix-its-installed-but-how-do-i-test

# If you need to make changes on postfix configuration, edit
# /etc/postfix/main.cf (and others) as needed.  To view Postfix configuration values, see postconf(1).
# After modifying main.cf, be sure to run '/etc/init.d/postfix reload'.

# If you find the local network address is missed from mynetwork shown by postconf mynetwork, please use postconf -e mynetwork="" to add the missed network 
