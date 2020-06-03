FROM debian

RUN apt-get update && apt-get install -y openssh-server \
          sudo \
          procps net-tools \
          nano vim

RUN mkdir /run/sshd

RUN useradd -m admin

RUN usermod -a -G sudo admin

RUN echo "admin:test" | chpasswd

COPY ./sshkey.pub /home/admin/.ssh/authorized_keys

EXPOSE 22

RUN apt-get install -y rsync

EXPOSE 873

RUN echo " \
lock file = /var/run/rsync.lock \
log file = /var/log/rsyncd.log \
pid file = /var/run/rsyncd.pid \
" > /etc/rsyncd.conf

#RUN echo ". /root/entrypoint.sh" >> /root/.profile
#RUN echo ". /root/entrypoint.sh" >> /root/.bashrc

RUN apt-get install -y nginx

EXPOSE 80
EXPOSE 443

RUN apt-get install -y php-fpm php-pgsql php-zip php-intl
RUN mkdir /run/php

RUN apt-get install openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
             -keyout /etc/ssl/private/selfsigned.key \
             -out /etc/ssl/certs/selfsigned.crt \
             -subj '/CN=monsitessl.fr/O=My Company Name LTD./C=US'
RUN openssl dhparam -out /etc/nginx/dhparam.pem 1024
RUN echo " \
ssl_certificate /etc/ssl/certs/selfsigned.crt; \
ssl_certificate_key /etc/ssl/private/selfsigned.key;" > /etc/nginx/snippets/selfsigned.conf
COPY ./nginx/ssl/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

RUN apt-get install -y ufw
#RUN sudo iptables -t filter -F
#RUN sudo iptables -t filter -X
#RUN ufw enable
#RUN ufw default deny ingoing
#RUN ufw allow 80
#RUN ufw allow 443
#RUN ufw allow 22
#RUN ufw allow 25
#RUN ufw reload

RUN apt-get install -y fail2ban
RUN mkdir /run/fail2ban
RUN rm /etc/fail2ban/jail.d/defaults-debian.conf

COPY ./fail2ban/jail.local /etc/fail2ban/jail.d/my-jail.conf
COPY ./fail2ban/monfiltre.conf /etc/fail2ban/filter.d/monfiltre.conf

RUN apt-get install -y postgresql
RUN useradd -m dev1

# Install Postfix.
RUN echo "postfix postfix/main_mailer_type string Internet site" > preseed.txt
RUN echo "postfix postfix/mailname string mail.example.com" >> preseed.txt
# Use Mailbox format.
RUN debconf-set-selections preseed.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y postfix mailutils
RUN mkdir -p /var/spool/postfix

RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y proftpd
RUN mkdir /run/proftpd

COPY ./postgres/init.sh /opt/.init_db.sh

COPY ./ufw/init.sh /opt/.init_ufw.sh

COPY ./nginx/www /var/www
COPY ./nginx/vhost /etc/nginx/sites-available

RUN ln -s /etc/nginx/sites-available/monsite.fr /etc/nginx/sites-enabled/monsite.fr
RUN ln -s /etc/nginx/sites-available/monsitephp.fr /etc/nginx/sites-enabled/monsitephp.fr
RUN ln -s /etc/nginx/sites-available/monsitessl.fr /etc/nginx/sites-enabled/monsitessl.fr

COPY ./entrypoint.sh /opt/.entrypoint.sh

WORKDIR /root

RUN chmod +x /opt/.entrypoint.sh
ENTRYPOINT ["/opt/.entrypoint.sh"]
