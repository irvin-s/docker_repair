ARG MYSQL_VERSION=latest
FROM mysql:${MYSQL_VERSION}

LABEL maintainer="Syncher <syncviip@gmail.com>"

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN chown -R mysql:root /var/lib/mysql/

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN chmod 644 /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
