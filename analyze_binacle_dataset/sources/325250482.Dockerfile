# Build
FROM prologic/go-builder:latest AS build

# Runtime
FROM alpine

COPY --from=build /src/cmd/je/je /je

EXPOSE 8000/tcp

VOLUME /data

ENTRYPOINT ["/je"]
CMD ["-datadir", "/data"]
