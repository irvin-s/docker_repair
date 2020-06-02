FROM obaidsalikeen/storm:0.9.3

MAINTAINER Obaid Salikeen <obaidsalikeen@gmail.com>

EXPOSE 8080

ADD configure-storm.sh /usr/bin/configure-storm.sh

CMD  /usr/bin/configure-storm.sh



