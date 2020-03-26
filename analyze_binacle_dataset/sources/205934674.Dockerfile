FROM scratch

MAINTAINER Jamie Hannaford <jamie.hannaford@rackspace.com>

COPY wiretap /
ENTRYPOINT ["/wiretap"]
