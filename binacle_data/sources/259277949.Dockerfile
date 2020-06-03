FROM golang:1.7.5

EXPOSE 8181

RUN mkdir -p /opt/example

COPY _output/go-expvar-example /opt/example

# Set a default user, any value will work here.
# Otherwise the default is root and can fail in certain OpenShift installations
USER 12345

ENTRYPOINT ["/opt/example/go-expvar-example"]
