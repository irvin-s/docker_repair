FROM phusion/baseimage:0.9.16
MAINTAINER Richard Genthner <moose@symplicity.com>

LABEL version="1.3.32"
LABEL description="This is the Antidote webserver, with NGINX and PHP-FPM"
LABEL "com.symplicity.vendor"="Symplicity Corp"


# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG  en_US.UTF-8
ENV LC_ALL  en_US.UTF-8

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

ADD build/scripts/run.sh /run.sh
RUN chmod +x /run.sh
ADD build/scripts/setup.sh /setup.sh
RUN chmod +x /setup.sh
ADD build/scripts/update.sh /update.sh
RUN chmod +x /update.sh
CMD ["/run.sh"]

#php install
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y vim curl wget build-essential software-properties-common zip unzip
RUN add-apt-repository -y ppa:ondrej/php5-5.6
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes php5-cli php5-fpm php5-mysql php5-sqlite php5-curl php5-gd php5-mcrypt php5-intl php5-imap php5-tidy git nodejs npm rsyslog

RUN sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/fpm/php.ini
RUN sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/cli/php.ini
# end php install

## Lumen Setting

# Install Nginx
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini

# setup directories
RUN mkdir -p /var/www
RUN mv /etc/nginx/sites-enabled /etc/nginx/sites-enabled.orig
RUN ln -s /etc/nginx/sites-available /etc/nginx/sites-enabled
RUN mkdir /etc/service/nginx
ADD build/nginx/nginx-sites/default  /etc/nginx/sites-available/default
ADD build/nginx/nginx-log.conf /etc/nginx/conf.d/nginx-log.conf
ADD build/phpfpm/www.conf /etc/php5/fpm/pool.d/www.conf
ADD build/rsyslog/45-nginx-access.log /etc/rsyslog.d/45-nginx-access.conf
ADD build/nginx/nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run
RUN mkdir /etc/service/phpfpm
ADD build/phpfpm/phpfpm.sh /etc/service/phpfpm/run
RUN chmod +x /etc/service/phpfpm/run
RUN rm -rf /etc/service/syslog-ng

EXPOSE 80 443
#End nginx

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Get code
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone https://github.com/moos3/arbeider.git /worker
RUN cd /worker && composer install
RUN mkdir /etc/service/worker
RUN ln -s /worker/run /etc/service/worker/run
