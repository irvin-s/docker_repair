FROM ubuntu:xenial

RUN \
  apt-get update && apt-get install -y rsync sudo parallel && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh

ENV USERID 500
ENV GROUPID 100

ENTRYPOINT ["/usr/local/bin/init.sh"]
CMD ["rsync"]
