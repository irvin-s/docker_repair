# Build
FROM prologic/go-builder:latest AS build

# Runtime
FROM alpine

COPY --from=build /src/bitraft /bitraft

EXPOSE 4920/tcp

VOLUME /data

ENTRYPOINT ["/bitraft"]
CMD ["-d", "/data"]
