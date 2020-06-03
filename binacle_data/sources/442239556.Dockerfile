#
# Postfix with POP3 and IMAP (courier)
#
# From this guide https://help.ubuntu.com/community/PostfixBasicSetupHowto
#
# IMPORTANT NOTE: The domain name needs to be changed from example.com below!
#

from ubuntu:latest
maintainer Jonas Colmsjö <jonas@gizur.com>

RUN apt-get update
RUN apt-get install -y language-pack-en
RUN update-locale LANG=en_US.UTF-8

# Good for debugging
RUN apt-get install -y  mutt dnsutils telnet nano


#
# Install Postfix.
#

RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
RUN echo "postfix postfix/mailname string mail.example.com" >> preseed.txt
# Use Mailbox format.
RUN debconf-set-selections preseed.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix

ADD ./etc-postfix-main.cf /etc/postfix/main.cf

# Needs to be done after postfix setup
ADD etc-aliases.txt /etc/aliases

#
# Setup smarthost
#
# Need to use smarthost when running in docker (since these IP-adresses often are blocked for spam purposes)
# See: http://www.inboxs.com/index.php/linux-os/mail-server/52-configure-postfix-to-use-smart-host-gmail

RUN echo smtp.gmail.com sendmail@gizur.com:fgdHC1Q2brbirFU40Vj5tceNQ8y1h46LLu/wplK2UnI= > /etc/postfix/relay_passwd
RUN chmod 600 /etc/postfix/relay_passwd
RUN postmap /etc/postfix/relay_passwd

#
# Installing syslog
#

RUN apt-get install -y rsyslog


#
# Setup mutt and users - for testing purposes
#

# Add a local user to receive mail at someone@example.com, with a delivery directory
# (for the Mailbox format).

# Two slightly different ways of adding a user
RUN useradd -m -s /bin/bash fmaster
RUN echo fmaster:password |chpasswd
ADD ./muttrc /home/fmaster/.muttrc

run useradd -m -s /bin/bash someone
RUN echo someone:password |chpasswd
run mkdir /var/spool/mail/someone
run chown someone:mail /var/spool/mail/someone


#
# Start things and expose SMTP (25), POP3 (110) and IMAP (143)
#


ADD ./start.sh /

expose 25
cmd ["/start.sh"]
