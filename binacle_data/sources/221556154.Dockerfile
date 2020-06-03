FROM        alpine:3.9
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

# Install packages
RUN         apk update && \
            apk upgrade && \
            apk add apache2 apache2-proxy shadow && \
            rm -rf /var/cache/apk/* /var/log/*

# Configure to use php fpm and don't use /var/www to store everything (modules and logs)
RUN         sed -i 's/LoadModule mpm_prefork_module/#LoadModule mpm_prefork_module/g' /etc/apache2/httpd.conf && \
            sed -i 's/#LoadModule mpm_event_module/LoadModule mpm_event_module/g' /etc/apache2/httpd.conf && \
            sed -i 's/#LoadModule rewrite_module/LoadModule rewrite_module/g' /etc/apache2/httpd.conf && \
            # remove useless module bundled with proxy
            sed -i 's/LoadModule lbmethod/#LoadModule lbmethod/g' /etc/apache2/conf.d/proxy.conf && \
            # change ServerRoot
            sed -i 's/var\/www\/localhost\/htdocs/var\/www/g' /etc/apache2/httpd.conf && \
            sed -i 's/ServerRoot \/var\/www/ServerRoot \/usr\/local\/apache/g' /etc/apache2/httpd.conf && \
            # change user and group
            sed -i 's/^User apache/User www-data/g' /etc/apache2/httpd.conf && \
            sed -i 's/^Group apache/Group www-data/g' /etc/apache2/httpd.conf && \
            # Prepare env and create user
            mkdir -p /var/log/apache2 && \
            groupdel www-data && \
            groupmod -g 101 -n www-data apache && \
            usermod  -g 101 -u 100 -l www-data -d /var/www apache && \
            chown www-data:www-data /var/log/apache2 /var/www && \
            # Clean base directory and create required ones
            rm -rf /var/www/* && \
            mkdir -p /run/apache2 /usr/local/apache && \
            ln -s /usr/lib/apache2 /usr/local/apache/modules && \
            ln -s /var/log/apache2 /usr/local/apache/logs

COPY        vhost.conf /etc/apache2/conf.d/vhost.conf

ENV         APACHE_UID  100
ENV         APACHE_GID  101

EXPOSE      80 443

COPY        run.sh     /run.sh
RUN         chmod u+x  /run.sh

CMD         ["/run.sh"]
