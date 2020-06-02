FROM postgres:9.6.2

# http://docs.docker.jp/engine/reference/builder.html#env
ENV POSTGRES_DB=db_test\
    POSTGRES_USER=db_user\
    POSTGRES_PASSWORD=password

EXPOSE 5432
