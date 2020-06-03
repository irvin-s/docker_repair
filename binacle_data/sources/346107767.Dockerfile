FROM phusion/baseimage:0.9.16
MAINTAINER Richard Genthner <moose@symplicity.com>

LABEL version="1.2.1"
LABEL description="This is the Antidote Development Server, with NGINX and PHP-FPM"
LABEL "com.symplicity.vendor"="Symplicity Corp"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG  en_US.UTF-8
ENV LC_ALL  en_US.UTF-8

ENV HOME /root
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

#php install
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y vim curl wget build-essential python-software-properties
RUN add-apt-repository -y ppa:ondrej/php5-5.6
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes php5-cli php5-fpm php5-mysql php5-sqlite php5-curl php5-gd php5-mcrypt php5-intl php5-imap php5-tidy git nodejs npm rsyslog

RUN sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/fpm/php.ini
RUN sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/cli/php.ini
# end php install

# Install Nginx
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini

# setup directories
RUN mv /etc/nginx/sites-enabled /etc/nginx/sites-enabled.orig
RUN ln -s /etc/nginx/sites-available /etc/nginx/sites-enabled
RUN mkdir -p /var/www
ADD build/nginx-sites/  /etc/nginx/sites-available/
ADD build/nginx.conf /etc/nginx/
RUN mkdir /etc/service/nginx
ADD build/nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run
RUN mkdir /etc/service/phpfpm
ADD build/phpfpm.sh /etc/service/phpfpm/run
RUN chmod +x /etc/service/phpfpm/run
RUN rm -rf /etc/service/syslog-ng


EXPOSE 80 22 443
#End nginx

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
RUN npm install -g node
RUN npm install -g bower
RUN npm install -g gulp
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -g dredd
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### App Fixes
RUN rm -rf /var/www/html
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
