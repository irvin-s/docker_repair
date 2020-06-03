FROM dockerfile/java:oracle-java8 

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -yq install mysql-server-5.5 && \
  rm -rf /var/lib/apt/lists/*

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Remove syslog configuration
RUN rm /etc/mysql/conf.d/mysqld_safe_syslog.cnf

# Add MySQL configuration
ADD data/config/my.cnf /etc/mysql/conf.d/my.cnf
ADD data/config/mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Add MySQL scripts
ADD data/scripts/run.sh /run.sh
RUN chmod 755 /run.sh

# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/etc/mysql", "/var/lib/mysql"]

ADD data/config/partiaId.json /data/partiaId.json
ADD data/config/poselId.json /data/poselId.json
ADD data/sql/create_demo_sejmngram_database_and_others.sql /data/create_demo_sejmngram_database_and_others.sql
ADD data/sql/insert_demo_data.sql /data/insert_demo_data.sql
ADD data/webapp/rest-server.jar /data/rest-server.jar
ADD data/config/config_demo.yml /data/config.yml

EXPOSE 8080
CMD ["/run.sh"]
