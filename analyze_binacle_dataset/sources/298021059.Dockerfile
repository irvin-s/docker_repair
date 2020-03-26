FROM centurylink/ca-certs
MAINTAINER Piotr Zduniak "piotr@zduniak.net"
EXPOSE 8080
EXPOSE 8081

WORKDIR /app

COPY backend /app/

ENTRYPOINT ["/app/backend"]
CMD ["--help"]
