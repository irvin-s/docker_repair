FROM swiftdocker/swift
MAINTAINER Jingkai He

ENV SWIFT_PATH /swift
RUN mkdir -p $SWIFT_PATH
WORKDIR $SWIFT_PATH

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
