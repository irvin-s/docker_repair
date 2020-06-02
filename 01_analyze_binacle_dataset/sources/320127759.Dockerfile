FROM clojure:lein-2.7.1-alpine

ADD build /opt/driver
WORKDIR /opt/driver

ENTRYPOINT ["/opt/driver/bin/driver"]

