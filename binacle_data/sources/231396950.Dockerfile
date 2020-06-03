FROM ubuntu:16.04
COPY webhook-service /usr/bin/
CMD ["webhook-service"]
