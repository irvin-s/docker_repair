FROM        debian:wheezy-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive


# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends && \
            # Set right repos
            echo "deb http://archive.debian.org/debian wheezy main contrib non-free" > /etc/apt/sources.list && \
            # Upgrade the system + Install all packages
            apt-get update && \
            apt-get upgrade -y && \
            # Install requirements
            apt-get install --reinstall -y --force-yes perl-base=5.14.2-21+deb7u3 libc6=2.13-38+deb7u10 libc-bin=2.13-38+deb7u10 && \
            apt-get install -y apache2 libapache2-mod-fastcgi && \
            # Clean
            apt-get clean && \
            apt-get autoremove -y && \
            rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

# Configuration
COPY        vhost.conf /etc/apache2/sites-available/vhost
RUN         a2enmod actions fastcgi rewrite && \
            a2dissite default && \
            a2ensite vhost && \
            mkdir /var/lib/php-fcgi


RUN         chmod 644 /var/log/apache2

ENV         APACHE_UID 33
ENV         APACHE_GID 33

EXPOSE      80

COPY        run.sh     /run.sh
RUN         chmod u+x  /run.sh

CMD         ["/run.sh"]
