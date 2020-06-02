FROM postgres
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB api_engine
ADD init.sql /docker-entrypoint-initdb.d/
