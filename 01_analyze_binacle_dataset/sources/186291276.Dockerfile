FROM cduez/squeeze:squeeze
MAINTAINER Matthias Kadenbach <matthias.kadenbach@gmail.com>

RUN apt-get update
RUN apt-get --force-yes -y install curl

RUN echo 'deb http://packages.dotdeb.org squeeze all' >> /etc/apt/sources.list
RUN curl -o /tmp/dotdeb.gpg http://www.dotdeb.org/dotdeb.gpg && apt-key add /tmp/dotdeb.gpg; rm -f /tmp/dotdeb.gpg; apt-key update
RUN apt-get update

RUN apt-get --force-yes -y install php5-fpm php5-mysql

RUN mv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf.backup
ADD php-fpm-www.conf /etc/php5/fpm/pool.d/www.conf

RUN sed -i -e 's/;daemonize = yes/daemonize = no/' /etc/php5/fpm/php-fpm.conf

# ip redirecting setup
RUN apt-get --force-yes -y install rinetd
RUN cp /etc/rinetd.conf /etc/rinetd.conf.backup

# add start script
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh


# bind volumes
VOLUME ["/www"]

# expose portsh
EXPOSE 20053

# run command
CMD ["start.sh"]
