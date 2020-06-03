FROM obaidsalikeen/storm:0.9.3

MAINTAINER Obaid Salikeen <obaidsalikeen@gmail.com>

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 6704


ADD configure-storm.sh /usr/bin/configure-storm.sh

CMD  /usr/bin/configure-storm.sh



