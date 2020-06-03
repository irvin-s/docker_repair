FROM alpine:3.7
MAINTAINER Thang Nguyen <thangn.1411@gmail.com>

VOLUME [ /ichaind ]
WORKDIR /ichaind
EXPOSE 46656 46657
ENTRYPOINT ["/usr/bin/wrapper.sh"]
CMD ["start"]
STOPSIGNAL SIGTERM

COPY wrapper.sh /usr/bin/wrapper.sh