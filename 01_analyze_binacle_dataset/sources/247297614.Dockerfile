FROM microsoft/mssql-server-linux:2017-CU2
MAINTAINER Shane Genschaw

VOLUME /docker-entrypoint-initdb.d
EXPOSE 1433

RUN ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd \
    && ln -s /opt/mssql-tools/bin/bcp /usr/local/bin/bcp
COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]