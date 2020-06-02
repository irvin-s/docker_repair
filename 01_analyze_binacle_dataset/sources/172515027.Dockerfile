FROM kiyoto/fluentd:0.10.56-2.1.1
MAINTAINER kiyoto@treausure-data.com
RUN mkdir /etc/fluent
ADD fluent.conf /etc/fluent/
RUN ["/usr/local/bin/gem", "install", "fluent-plugin-record-reformer", "--no-rdoc", "--no-ri"]
ENTRYPOINT ["/usr/local/bin/fluentd", "-c", "/etc/fluent/fluent.conf"]
