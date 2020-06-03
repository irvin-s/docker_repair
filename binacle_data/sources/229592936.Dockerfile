FROM alpine:3.3

MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>

RUN apk add --update \
      curl \
      bash \
      jq

CMD ["/bin/sh"]


# Run it as
#
#		docker run -it --rm ipedrazas/alpine:curl
#
