FROM alpine:3.1
MAINTAINER Carter Morgan <askcarter@google.com>
ADD dbd /usr/bin/dbd
ADD test ~/test
CMD ["dbd", "-f", "~/test"]
