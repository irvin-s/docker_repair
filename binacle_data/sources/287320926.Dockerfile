FROM scratch
EXPOSE 9112
WORKDIR /
COPY newrelic_exporter .
ENTRYPOINT ["./newrelic_exporter"]