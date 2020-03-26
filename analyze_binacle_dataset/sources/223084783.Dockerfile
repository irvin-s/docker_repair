FROM scratch
MAINTAINER Seth Jennings <sjenning@redhat.com>

ADD serve-hostname /

CMD ["/serve-hostname"]
