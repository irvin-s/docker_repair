# Dockerfile for an email server with postfix and dovecot.
#

FROM dsissitka/ubunturaring
MAINTAINER Nicolas Cadou <ncadou@cadou.ca>

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'deb http://archive.ubuntu.com/ubuntu raring main universe' > /etc/apt/sources.list
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean

# Install Ansible
RUN apt-get install -y --no-install-recommends \
        python-apt python-jinja2 python-paramiko python-pip python-yaml \
    && apt-get clean \
    && pip install ansible

# Upstart doesn't work inside a docker container, so we deactivate it to work
# around post-install scripts that want to talk to it and fail when they can't.
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -s /bin/true /sbin/initctl

ENV RANDOMIZE_PASSWORD 0
ENV MAILNAME mailserver.local
ENV VMAIL_USER vmail
ENV VMAIL_UID 150
ENV VMAIL_GROUP mail
ENV VMAIL_GID 8
ENV VMAIL_DIR /var/vmail
ENV VIMBADMIN_SALT 123
ENV VIMBADMIN_VER 2.2.2
ENV VIMBADMIN_HOSTNAME mailserver.local

# Install and setup the mail server
RUN bash -c 'debconf-set-selections <<< "postfix postfix/mailname string $MAILNAME"'
RUN apt-get install -y --no-install-recommends \
        amavis bcrypt bsd-mailx clamav clamav-daemon curl dovecot-core \
        dovecot-imapd dovecot-managesieved dovecot-pop3d dovecot-sieve \
        dovecot-sqlite git libgpgme11 libpth20 libpython-stdlib \
        libpython2.7-minimal libpython2.7-stdlib libtokyocabinet9 logrotate \
        mutt nginx openssh-server php5-cli php5-fpm php5-sqlite postfix postgrey \
        procmail pwgen python python-minimal python2.7 python2.7-minimal rsyslog \
        spamassassin ssl-cert subversion \
    && apt-get clean

RUN rm /var/run/postgrey.pid

RUN apt-get install -y --no-install-recommends \
        htop less moreutils tree telnet net-tools psmisc sqlite3 vim-nox \
    && apt-get clean

RUN freshclam

ADD ansible /.ansible
RUN /.ansible/setup-base.sh

EXPOSE 22 25 80 110 143 465 993 995
VOLUME ["/var/vmail"]
CMD ["/start"]
