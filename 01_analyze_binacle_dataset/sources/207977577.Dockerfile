FROM centurylink/ca-certs
WORKDIR /app
COPY KongBeat /app/
COPY static /app/static
ENTRYPOINT ["./KongBeat"]
