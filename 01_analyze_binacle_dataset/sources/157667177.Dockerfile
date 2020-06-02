FROM ubuntu:trusty

ENV HOME /root

ADD apps /apps

VOLUME ["/data-logs"]

# Define default command.
CMD ["/apps/bin/keep_alive"]

