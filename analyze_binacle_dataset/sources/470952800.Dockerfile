FROM alpine:latest
RUN apk --no-cache add ca-certificates
ADD raftcat/templates /raftcat/templates
ADD raftcat/static /raftcat/static
ADD raftcat.x86_64-unknown-linux-musl /bin/raftcat
EXPOSE 8080
ENTRYPOINT ["/bin/raftcat"]
