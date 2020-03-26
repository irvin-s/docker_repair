FROM ubuntu:trusty

ENV HOME /root

ADD apps /apps

VOLUME ["/seldon-models"]

# Define default command.
CMD ["/apps/bin/keep_alive"]

