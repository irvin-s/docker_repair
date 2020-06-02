FROM alpine:3.6

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src

RUN apk add --no-cache make git curl ca-certificates musl-dev gcc m4 patch ncurses ocaml opam
RUN opam init -a --root=/opt/driver/opam
RUN eval `opam config env --root=/opt/driver/opam --shell=sh` && \
		opam install ocamlbuild yojson ppx_deriving_yojson base64

WORKDIR /opt/driver/src