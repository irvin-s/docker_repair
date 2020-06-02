# import main image
FROM postgres:9.4

# set environment variables
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD pydata

# initialise
ADD conf/initialise_all.sh /docker-entrypoint-initdb.d/
ADD conf/postgresql.conf /postgresql.conf
RUN chmod +r /postgresql.conf
