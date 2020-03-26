FROM resin/armhf-alpine

RUN apk add --update ruby

WORKDIR /downloads
CMD /usr/bin/ruby -run -ehttpd . -p80
