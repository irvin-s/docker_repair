FROM debian:jessie

RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-php5 php5-mysql php5-apcu php5-mcrypt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite && \
    rm -rf /var/www/*

COPY libs /var/www/libs
COPY app /var/www/app
COPY document_root /var/www/html

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_SERVER_NAME localhost

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-D", "FOREGROUND"]
