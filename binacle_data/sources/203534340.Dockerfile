FROM debian:jessie

COPY classlogger/classlogger /usr/bin/classlogger
ENTRYPOINT /usr/bin/classlogger
