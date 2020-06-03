FROM golang

WORKDIR /app

COPY influxdb-relay .
COPY test.toml .

EXPOSE 9096
CMD ["./influxdb-relay", "-config", "test.toml", "-v"]
