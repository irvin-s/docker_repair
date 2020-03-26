FROM busybox
MAINTAINER Michał Kosek <michalkk@student.iln.uio.no>

RUN adduser -Du 61054 glossa && mkdir /corpora && chown glossa /corpora
VOLUME /corpora
CMD ["echo", "OK"]
