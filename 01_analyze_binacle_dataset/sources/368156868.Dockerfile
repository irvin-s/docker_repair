# Dovecot & Postfix for Openchange
FROM ubuntu:14.04

RUN apt-get update

# Allow postfix to install without interaction.
RUN echo "postfix postfix/mailname string example.com" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

RUN apt-get install -y openssh-server dovecot-imapd postfix

RUN mkdir /var/run/sshd
ADD dovecot.conf /etc/dovecot/dovecot.conf
ADD dovecot-ldap.conf /etc/dovecot/dovecot-ldap.conf
ADD postfix.cf /postfix.cf.test
RUN cat /postfix.cf.test >> /etc/postfix/main.cf && rm /postfix.cf.test

RUN groupadd test
RUN useradd -g test -m -s /bin/bash test
RUN echo "root:root" | chpasswd
RUN echo "test:test" | chpasswd

ADD init.sh /init.sh

CMD ["/init.sh"]
