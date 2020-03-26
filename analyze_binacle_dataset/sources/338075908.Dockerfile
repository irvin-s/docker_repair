FROM postgres:alpine
COPY init/congress.sql /docker-entrypoint-initdb.d/00-congress.sql
COPY init/initdata.sql /docker-entrypoint-initdb.d/10-initdata.sql
LABEL Decription="Congress PostgreSQL database"
ENV POSTGRES_USER=congress
ENV POSTGRES_PASSWORD=thepassword
