#
# http static server one-liners
#

FROM busybox:1.30

ADD * /app/
WORKDIR /app


# Configurable host:port - location of backend todoapi server
ENV TODOAPI_HOST localhost
ENV TODOAPI_PORT 30080

EXPOSE 80
CMD ["./run.sh"]
