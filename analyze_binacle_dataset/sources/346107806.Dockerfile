FROM phusion/baseimage:0.9.16
MAINTAINER Richard Genthner <moose@symplicity.com>

LABEL version="1.3.32"
LABEL description="This is the Antidote Worker, with PHP 5.6"
LABEL "com.symplicity.vendor"="Symplicity Corp"

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG  en_US.UTF-8
ENV LC_ALL  en_US.UTF-8

ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD build/scripts/run.sh /run.sh
RUN chmod +x /run.sh
ADD build/scripts/setup.sh /setup.sh
RUN chmod +x /setup.sh
ADD build/scripts/update.sh /update.sh
RUN chmod +x /update.sh
RUN ln -s /var/www/deployment/jobs/antidote-cron /etc/cron.d/antidote
CMD ["/run.sh"]

#php install
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y vim curl wget build-essential python-software-properties git rsyslog zip
RUN add-apt-repository -y ppa:ondrej/php5-5.6
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y --force-yes php5-cli php5-mysql php5-sqlite php5-curl php5-gd php5-mcrypt php5-intl php5-imap php5-tidy
RUN sed -i "s/;date.timezone = .*/date.timezone = UTC/" /etc/php5/cli/php.ini
# end php install
RUN rm -rf /etc/service/syslog-ng

# setup directories
RUN mkdir -p /var/www

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Get code
RUN touch /root/.ssh/known_hosts && ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN git clone https://github.com/moos3/arbeider.git /worker
RUN cd /worker && composer install
RUN mkdir /etc/service/worker
RUN ln -s /worker/run /etc/service/worker/run
