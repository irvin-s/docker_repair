FROM obaidsalikeen/storm:0.9.3

MAINTAINER Obaid Salikeen <obaidsalikeen@gmail.com>

EXPOSE 6627
EXPOSE 3772
EXPOSE 3773

ADD configure-storm.sh /usr/bin/configure-storm.sh

# Run Commands that will execute when container runs

CMD /usr/bin/configure-storm.sh