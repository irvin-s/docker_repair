FROM mariadb:10.3.8
COPY ./init-db.sql /docker-entrypoint-initdb.d/ 
ENV MYSQL_ROOT_PASSWORD dashboard123
ENV MYSQL_DATABASE MyDashboard
ENV MYSQL_USER dashboard
ENV MYSQL_PASSWORD dashboard123