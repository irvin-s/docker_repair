# This Dockerfile builds chazomaticus/minit.
#
# Before building the image, you should compile minit and copy the binary into
# this directory.  If building a version of ubuntu other than the latest, edit
# the FROM line appropriately as well.
#
# When it's ready, build with something like:
#     sudo docker build -t minit-base .

FROM ubuntu
MAINTAINER Charles Lindsay <chaz@chazomatic.us>

ADD minit /sbin/minit

ENTRYPOINT ["/sbin/minit"]
