FROM scratch
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>

ADD ping-redis /

CMD ["/ping-redis"]
