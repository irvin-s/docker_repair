# We don't use a multi-stage build, as it prevents using a Docker volume
# for the ~/.cargo cache (see Makefile)

FROM scratch

WORKDIR /risso
COPY target/risso_actix-musl-release .
CMD ["/risso/risso_actix"]
