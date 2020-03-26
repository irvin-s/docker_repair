FROM ubuntu:14.04

ENV UPDATED_AT 2015-02-01

RUN apt-get update

RUN apt-get install -y \
    curl \
    gcc \
    make

RUN curl -L http://cpanmin.us | perl - App::cpanminus

RUN cpanm Dancer
RUN cpanm DBD::SQLite
RUN cpanm SQL::Easy
RUN cpanm Moment
RUN cpanm lib::abs
RUN cpanm File::Slurp
RUN cpanm SQL::Abstract
RUN cpanm JSON

COPY bin/ /curry/bin/
COPY lib/ /curry/lib/
COPY data/ /curry/data/

EXPOSE 3000

WORKDIR /curry
RUN ./bin/create_initial_db.pl

CMD perl -Ilib bin/app.psgi
