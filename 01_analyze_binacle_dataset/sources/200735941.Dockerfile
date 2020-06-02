FROM alpine:edge
MAINTAINER Naerymdan <vincent.dev@gmail.com>
##
# Mysql 5.7+
##

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S mysql && adduser -S -g mysql mysql

# FATAL ERROR: please install the following Perl modules before executing /usr/local/mysql/scripts/mysql_install_db:
# File::Basename
# File::Copy
# Sys::Hostname
# Data::Dumper
RUN apk upgrade -U \
    && apk --update add \
	    mysql \
		mysql-client \
		tzdata bash \
    && rm -rf /var/cache/apk/* \
	&& rm -rf /var/lib/mysql
	
	
RUN mkdir /docker-entrypoint-initdb.d \
    && mkdir /var/lib/mysql \
	&& mkdir /run/mysqld

COPY custom.cnf              /etc/mysql/my.cnf
COPY stopwords.txt           /stopwords.txt
COPY docker-entrypoint.sh    /

# comment out a few problematic configuration values
RUN chmod 644 /etc/mysql/my.cnf \
    && chmod +x /docker-entrypoint.sh \
    && sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf

VOLUME /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["mysqld"]