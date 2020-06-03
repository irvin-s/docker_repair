FROM ubuntu
ENV sql_password sql
ENV TERM xterm
RUN apt-get update; DEBIAN_FRONTEND=noninteractive apt-get -y install cron mariadb-client mariadb-server

#Cron Jobs
RUN echo "00 23 * * 0 /sync.sh" >> /crontab
RUN echo "00 * * * * mysqladmin flush-hosts" >> /crontab
RUN crontab /crontab
ADD sync.sh /
RUN chmod +x /sync.sh

#MySQL Config
ADD 50-server.cnf /etc/mysql/mariadb.conf.d/

RUN rm -rf /var/lib/mysql/*

#Startup Script
ADD start.sh /
RUN chmod +x /start.sh


EXPOSE 3306
CMD /start.sh
