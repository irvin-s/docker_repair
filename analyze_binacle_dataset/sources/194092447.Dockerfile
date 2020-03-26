FROM zanox/mysql

COPY database.sql /schema/

RUN start-mysql && \
    mysql < /schema/database.sql && \
    stop-mysql
