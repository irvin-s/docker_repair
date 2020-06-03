FROM ubuntu:12.04
MAINTAINER jmaicher@mail.upb.de

# Install basics
RUN apt-get -y update && apt-get -y install sudo

# Install postgresql 9.1 and generate en_US.UTF-8 locale
RUN locale-gen en_US.UTF-8
RUN LC_ALL=en_US.UTF-8 \
    apt-get -y install postgresql postgresql-contrib-9.1

ADD postgresql.conf /etc/postgresql/9.1/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

# ?
VOLUME  ["/var/lib/postgresql"]

# Expose the postgres port
EXPOSE 5432

CMD ["/usr/local/bin/run"]

