FROM postgres:10.2-alpine
COPY init-db.sql /docker-entrypoint-initdb.d/
ENV POSTGRES_USER weatherapp
ENV POSTGRES_PASSWORD weatherapp123
ENV POSTGRES_DB weather