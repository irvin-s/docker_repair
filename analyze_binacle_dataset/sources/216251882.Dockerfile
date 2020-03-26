###
# Perl-based Okapi module docker
# To build:
#  docker build -t folio-simple-perl-module .
# To run:
#   docker run -t -i -p 8080:8080 folio-simple-perl-module
###


#FROM perl:5.20
FROM debian:8

ENV PERL_FILE simple.pl

RUN apt-get update && apt-get -y install libnet-server-perl libjson-perl libcgi-pm-perl libmodule-build-perl libwww-perl

# Set the location of the script
ENV PERL_HOME /usr/okapi

EXPOSE 8080

# Copy your fat jar to the container
COPY ./$PERL_FILE $PERL_HOME/

# Launch the module
WORKDIR $PERL_HOME
ENTRYPOINT ["perl", "simple.pl"]
