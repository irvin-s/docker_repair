FROM mysql:latest

MAINTAINER yesterday679 <yesterday679@gmail.com>

ARG TZ=UTC
ARG MYSQL_USER=user
ARG MYSQL_PASSWORD=password
ARG MYSQL_ROOT_PASSWORD=root

ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=test
ENV TZ ${TZ}

ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD startup /etc/mysql/startup

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && sed -i 's/MYSQL_USER/'$MYSQL_USER'/g' /etc/mysql/startup \
    && sed -i 's/MYSQL_DATABASE/'$MYSQL_DATABASE'/g' /etc/mysql/startup \
    && sed -i 's/MYSQL_PASSWORD/'$MYSQL_PASSWORD'/g' /etc/mysql/startup

EXPOSE 3306
CMD ["mysqld", "--init-file=/etc/mysql/startup"]
